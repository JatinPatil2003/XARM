FROM ros:humble-ros-base AS chacher

WORKDIR /opt/XARM/src

COPY XARM ./XARM

WORKDIR /opt

RUN find . -name "src" -type d \
  -mindepth 1 -maxdepth 2 -printf '%P\n' \
  | xargs -I % mkdir -p /tmp/opt/% && \
  find . -name "package.xml" \
  | xargs cp --parents -t /tmp/opt && \
  find . -name "COLCON_IGNORE" \
  | xargs cp --parents -t /tmp/opt || true


FROM osrf/ros:humble-desktop-full AS builder

# Environment setup
ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO=humble

SHELL ["/bin/bash", "-c"]

# Install essential tools and ROS build tools
RUN apt update && apt install -y \
  build-essential \
  git \
  wget \
  curl \
  lsb-release \
  sudo \
  python3-pip \
  python3-colcon-common-extensions \
  python3-rosdep \
  python3-vcstool \
  && rm -rf /var/lib/apt/lists/*

# Set locale
RUN apt-get update && apt-get install -y locales && \
  locale-gen en_US en_US.UTF-8 && \
  update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
  export LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

WORKDIR /opt/XARM

COPY --from=chacher /tmp/opt/XARM ./

RUN . /opt/ros/humble/setup.bash && \
  apt-get update && rosdep install -q -y \
  --from-paths src \
  --ignore-src \
  && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt upgrade -y \
  && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash ubuntu && \
  usermod -aG sudo ubuntu && \
  echo "ubuntu ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
  
COPY --chown=ubuntu:ubuntu . /home/ubuntu/XARM

RUN chown -R ubuntu:ubuntu /home/ubuntu/XARM

WORKDIR /home/ubuntu/XARM

RUN echo "source /opt/ros/humble/setup.bash" >> /home/ubuntu/.bashrc && \
  echo "source /home/ubuntu/XARM/install/setup.bash" >> /home/ubuntu/.bashrc && \
  echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> /home/ubuntu/.bashrc && \
  echo "alias so='source install/setup.bash; echo ----Sourced----'" >> /home/ubuntu/.bashrc && \
  echo "alias cbs='colcon build --symlink-install; so'" >> /home/ubuntu/.bashrc

USER ubuntu
