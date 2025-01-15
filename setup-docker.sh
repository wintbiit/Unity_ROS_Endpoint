#!/bin/bash
source /opt/ros/$ROS_DISTRO/setup.bash
dir=$(pwd)

echo "WORKSPACE DIR: $dir"

cd $dir
mkdir src
mv src_tmp/livox_ros_driver2 src/livox_ros_driver2

catkin_make

source devel/setup.bash

mv src_tmp/* src/
rm -rf src_tmp

catkin_make

source devel/setup.bash

catkin_make

source devel/setup.bash

echo "Add the following line to your .bashrc file:"
echo "export ROS_WORKSPACE=$dir"
echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> /root/.bashrc
echo "source $ROS_WORKSPACE/devel/setup.bash" >> /root/.bashrc