# Base image with ROS 2 Humble desktop-full
FROM osrf/ros:humble-desktop-full

# Environment setup
ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO=humble

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
    ros-humble-moveit \
    ros-humble-gazebo-ros-pkgs \
    ros-humble-hardware-interface \
    ros-humble-controller-manager-msgs \
    ros-humble-control-toolbox \
    ros-humble-controller-manager \
    ros-humble-filters \
    && rm -rf /var/lib/apt/lists/*

# Set locale
RUN apt-get update && apt-get install -y locales && \
    locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 && \
    export LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Create a non-root user for VS Code
RUN useradd -m vscode && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER vscode

# Source ROS setup in bashrc
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
RUN echo 'source /home/vscode/XARM/install/setup.bash' >> ~/.bashrc

USER root

COPY . /home/vscode/XARM

WORKDIR /home/vscode/XARM

SHELL ["/bin/bash", "-c"]

RUN source /opt/ros/humble/setup.sh \
    && colcon build

