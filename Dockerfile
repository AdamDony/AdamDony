# Use the official ROS image as a base
FROM ros:melodic-ros-core

# Set environment variables
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-dev \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# Create a workspace
RUN mkdir -p /home/ros/catkin_ws/src
WORKDIR /home/ros/catkin_ws

# Copy source files
COPY ./src ./src

# Set up entrypoint
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
