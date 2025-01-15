ARG ROS_DISTRO=noetic

FROM ros:${ROS_DISTRO}-ros-base

ENV ROS_WORKSPACE=/catkin_ws
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

## ROS Deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    tzdata \
    cmake \
    python3-pip \
    python3-rosdep \
    python3-rosinstall \
    python3-rosinstall-generator \
    ros-$ROS_DISTRO-foxglove-bridge && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 10

# Setup ROS workspace
WORKDIR $ROS_WORKSPACE
COPY ./ros-tcp-endpoint $ROS_WORKSPACE/src/ros-tcp-endpoint
COPY ./ros-unity-endpoint $ROS_WORKSPACE/src/ros-unity-endpoint
RUN /bin/bash -c "source /opt/ros/$ROS_DISTRO/setup.bash && catkin_make" && \
    /bin/bash -c "source /opt/ros/$ROS_DISTRO/setup.bash && source $ROS_WORKSPACE/devel/setup.bash && rosdep install --from-paths $ROS_WORKSPACE/src --ignore-src -r -y"

EXPOSE 10000
EXPOSE 11311
EXPOSE 8765
VOLUME /root/.ros/log
ENTRYPOINT ["bash", "-c", "source ${ROS_WORKSPACE}/devel/setup.bash && roslaunch ros_unity_endpoint entrypoint.launch"]