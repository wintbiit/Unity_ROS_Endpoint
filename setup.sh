#!/bin/bash

default_dir=$(pwd)
# 根据脚本参数、环境变量ROS_WORKSPACE、默认值的优先级，设置dir的值
dir=${1:-${ROS_WORKSPACE:-$default_dir}}

echo "WORKSPACE DIR: $dir"
export ROS_WORKSPACE=$dir

mkdir -p $dir/src $dir/src_tmp

cp -r ./sentinel/src $dir/src_tmp
cp -r ./ros-tcp-endpoint $dir/src_tmp/ros_tcp_endpoint
cp -r ./ros-simulatorx $dir/src_tmp/ros_simulatorx

cd $dir
mv src_tmp/livox_ros_driver2 src/

catkin_make

source devel/setup.bash

mv src_tmp/* src/
rm -rf src_tmp

catkin_make

source devel/setup.bash

echo "Add the following line to your .bashrc file:"
echo "export ROS_WORKSPACE=$dir"
