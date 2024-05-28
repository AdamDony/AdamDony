FROM ros:melodic-ros-core

# Maintainer and Description
LABEL maintainer="Adam Dony <nuradamdonyeeeruet@gmail.com>"
LABEL description="Repository for EECE5560 assignments and labs"
LABEL version="daffy"

# Setup environment
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-dev \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install ROS packages
RUN apt-get update && apt-get install -y \
    ros-melodic-ros-base \
    && rm -rf /var/lib/apt/lists/*

# Create workspace
RUN mkdir -p /home/ros/catkin_ws/src

WORKDIR /home/ros/catkin_ws

# Copy source files
COPY ./src ./src

# Build the workspace
RUN /bin/bash -c "source /opt/ros/melodic/setup.bash && catkin_make"

# Source the setup.bash file
RUN echo "source /home/ros/catkin_ws/devel/setup.bash" >> ~/.bashrc

# Set the default command to run when starting the container
CMD ["bash"]

