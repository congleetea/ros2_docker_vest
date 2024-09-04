FROM hub.atomgit.com/amd64/ros:noetic
RUN sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu\//http:\/\/mirrors.aliyun.com\/ubuntu\//g' /etc/apt/sources.list && \
    sed -i 's/http:\/\/security.ubuntu.com\/ubuntu\//http:\/\/mirrors.aliyun.com\/ubuntu\//g' /etc/apt/sources.list && \
    apt-get update
RUN apt update && apt install -y --no-install-recommends \
		ros-noetic-desktop* \
    && rm -rf /var/lib/apt/lists/*
RUN apt update && apt install -y --no-install-recommends \
	python3-pip \
	vim net-tools \
	python3-osrf-pycommon \
	python3-catkin-tools \
	unzip libtool git \
	libprotobuf-dev protobuf-compiler \
	libbullet-dev \
	libsdl1.2-dev  \
	libsdl-image1.2-dev \
	libtar-dev \
	language-pack-zh-hans \
	fontconfig \
	gdb xterm libcgal-dev
# RUN apt update && apt install -y --no-install-recommends \
#   libgraphicsmagick1-dev libgraphicsmagick++1-dev \
#   ros-humble-diagnostic-updater \
#   ros-humble-bondcpp \
#   ros-humble-test-msgs \
#   ros-humble-geographic-msgs \
#   ros-humble-gazebo-ros-pkgs \
#   ros-humble-libg2o \
#   && rm -rf /var/lib/apt/lists/*
# RUN apt update && apt install -y --no-install-recommends \
#   libcgal-dev \
#   libceres-dev \
#   python3-pip \
#   xtensor-dev \
#   libompl-dev \
#   && rm -rf /var/lib/apt/lists/*
# # for cross compile
# RUN apt update && apt install -y --no-install-recommends \
#   gcc-aarch64-linux-gnu \
#   g++-aarch64-linux-gnu \
#   && rm -rf /var/lib/apt/lists/*
RUN useradd -ms /bin/bash ros1vest
RUN echo 'ros1vest:123' | chpasswd
RUN usermod -aG sudo ros1vest
WORKDIR /home/ros1vest
USER ros1vest
ENTRYPOINT ["/ros_entrypoint.sh"]
