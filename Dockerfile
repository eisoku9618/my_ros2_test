FROM ubuntu:xenial

MAINTAINER eisoku

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

RUN apt update

RUN apt install -y lsb-release emacs sudo git wget curl byobu htop
RUN curl http://repo.ros2.org/repos.key | apt-key add -
RUN sh -c 'echo "deb [arch=amd64,arm64] http://repo.ros2.org/ubuntu/main xenial main" > /etc/apt/sources.list.d/ros2-latest.list'
RUN apt update

RUN apt install -y build-essential cppcheck cmake libopencv-dev python-empy python3-dev python3-empy python3-nose python3-pip python3-pyparsing python3-setuptools python3-vcstool python3-yaml libtinyxml-dev libeigen3-dev
# dependencies for testing
RUN apt install -y clang-format pydocstyle pyflakes python3-coverage python3-mock python3-pep8 uncrustify

RUN pip3 install --upgrade pip
# Install argcomplete for command-line tab completion from the ROS2 tools.
# Install from pip rather than from apt-get because of a bug in the Ubuntu 16.04 version of argcomplete:
RUN pip3 install argcomplete
# additional testing dependencies from pip (because not available on ubuntu 16.04)
RUN pip3 install flake8 flake8-blind-except flake8-builtins flake8-class-newline flake8-comprehensions flake8-deprecated flake8-docstrings flake8-import-order flake8-quotes pytest pytest-cov pytest-runner
# dependencies for FastRTPS
RUN apt install -y libasio-dev libtinyxml2-dev
# If you are compiling beta-1 or older you also need to install boost for Fast-RTPS
RUN apt install -y libboost-chrono-dev libboost-date-time-dev libboost-program-options-dev libboost-regex-dev libboost-system-dev libboost-thread-dev
# dependencies for RViz
RUN apt install -y libcurl4-openssl-dev libqt5core5a libqt5gui5 libqt5opengl5 libqt5widgets5 libxaw7-dev libgles2-mesa-dev libglu1-mesa-dev qtbase5-dev

RUN mkdir -p ~/ros2_ws/src && \
cd  ~/ros2_ws && \
wget https://raw.githubusercontent.com/ros2/ros2/release-latest/ros2.repos && \
vcs-import src < ros2.repos
RUN apt install libopensplice67

CMD ["/bin/bash"]
