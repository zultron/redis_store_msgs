#!/bin/bash -xe

for f in $(find /etc/apt -name \*.list); do
    sed -i $f -e 's/^# *\(deb-src.*\)$/\1/'
done

# Bootstrap ROS installation
# http://wiki.ros.org/noetic/Installation/Source

echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" \
    > /etc/apt/sources.list.d/ros-latest.list
apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' \
    --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
apt-get update

pip3 install -U \
    vcstool \
    rosdep \
    rosinstall-generator \

apt-get install -y \
    build-essential

rosdep init
rosdep update


# Run bloom
# https://gist.github.com/awesomebytes/196eab972a94dd8fcdd69adfe3bd1152
pip3 install -U \
    bloom
source /etc/os-release
mv files/package.xml .
bloom-generate rosdebian --os-name $ID --os-version $VERSION_CODENAME \
    --ros-distro noetic
