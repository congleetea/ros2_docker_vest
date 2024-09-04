FROM hub.atomgit.com/amd64/ros:humble
RUN sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu\//http:\/\/mirrors.aliyun.com\/ubuntu\//g' /etc/apt/sources.list && \
    sed -i 's/http:\/\/security.ubuntu.com\/ubuntu\//http:\/\/mirrors.aliyun.com\/ubuntu\//g' /etc/apt/sources.list && \
    apt-get update
RUN apt update && apt install -y --no-install-recommends \
		ros-humble-desktop=0.10.0-1* \
    && rm -rf /var/lib/apt/lists/*
RUN apt update && apt install -y --no-install-recommends \
	libgraphicsmagick1-dev libgraphicsmagick++1-dev \
	ros-humble-diagnostic-updater \
	ros-humble-bondcpp \
	ros-humble-test-msgs \
	ros-humble-geographic-msgs \
	ros-humble-gazebo-ros-pkgs \
	ros-humble-libg2o \
	&& rm -rf /var/lib/apt/lists/*
RUN apt update && apt install -y --no-install-recommends \
	libcgal-dev \
	libceres-dev \
	python3-pip \
	xtensor-dev \
	libompl-dev \
	&& rm -rf /var/lib/apt/lists/*
# for cross compile
RUN apt update && apt install -y --no-install-recommends \
	gcc-aarch64-linux-gnu \
	g++-aarch64-linux-gnu \
	&& rm -rf /var/lib/apt/lists/*
RUN pip3 install setuptools==58.2.0
RUN useradd -ms /bin/bash ros2vest
RUN echo 'ros2vest:123' | chpasswd
RUN usermod -aG sudo ros2vest
WORKDIR /home/ros2vest
USER ros2vest
ENTRYPOINT ["/ros_entrypoint.sh"]
