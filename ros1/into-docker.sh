#!/usr/bin/env bash

function help() {
	echo "------------------------------------"
	echo "# usage: "
	echo "./into-docker.sh [-a] | [-b] "
	echo "  -a: 表示会同时将cleinbot和naigation2"
	echo "      都加入到docker中进行编译, 不加这"
	echo "      个参数则只加入navigation2进行编译"
	echo "  -b: 表示会重新构建镜像"
	echo "------------------------------------"
}

PWD_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)
########## utils functions ##################
function echo_info(){
	echo -e "\033[37m >>> $1 \033[0m"
}

function echo_warn(){
	echo -e "\033[34m >>> $1 \033[0m"
}

function echo_error(){
	echo -e "\033[31m >>> $1 \033[0m"
}

########## Compile Docker image ########
image_name=ros1/noetic
new_build_docker=false
machine_ws=$HOME/.ros/ros1_ws
container_ws=catkin_ws
image_user=ros1vest
image_home=/home/ros1vest
if docker images -q $image_name | grep -q .; then
	echo "Image existed."
else
	echo "Image not existed, building ....."
	docker build . -t $image_name
	new_build_docker=true
fi
if ! options=$(getopt -o p:b -l packages,build -- "$@")
then
	help
  exit 1
fi

set -- $options
while [ $# -gt 0 ];do
	case $1 in
		-p|--packages)
			eval packages=$2
			echo_info "package list: $packages"
			shift ;;
		-b|--build)
			echo_info "rebuild docker image."
		  if [ "$new_build_docker" = "true" ];then
		  	echo "Just build new image."
		  else
		  	echo "Building....."
		  	docker build . -t $image_name
		  fi
			shift ;;
		--) shift;
			break;; *) echo_error "Invalud option: $1"
			help
			exit 1
			;;
	esac
	shift
done
mkdir -p $HOME/.ros/$machine_ws/build
mkdir -p $HOME/.ros/$machine_ws/devel
docker run -ti --rm --network=host \
  -v $machine_ws/build:$image_home/$container_ws/build \
  -v $machine_ws/devel:$image_home/$container_ws/devel \
	--name ros1_builder \
	$image_name /bin/bash
