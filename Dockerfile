FROM ros:melodic-ros-core

# Setup environment
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Install dependencies
RUN apt-get update && apt-get install -y \n    python3-pip \n    python3-dev \n    build-essential \n    cmake \n    git \n    && rm -rf /var/lib/apt/lists/*

# Install ROS packages
RUN apt-get update && apt-get install -y \n    ros-melodic-ros-base \n    && rm -rf /var/lib/apt/lists/*

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
