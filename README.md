# Sentinel For SimulatorX Using ROS for Unity

## Setup 
### 1. Prepare ROS Environment
1. Install `ros`
```bash
wget http://fishros.com/install -O fishros && . fishros
```
2. Install `opencv`
3. Install `ros-pcl` `ros-gazebo` `ros-eigen`
### 2. Clone this repo
```bash
git clone ssh://git@git.scutbot.cn:23232/Simulator/Sentinel_ROS.git .
```

### 3. Run Setup Script
```bash
export ROS_WORKSPACE=/path/to/your/workspace
bash setup.sh
```

### 4. Run ROS Node
```bash
roslaunch ros_tcp_endpoint entrypoint.launch
```