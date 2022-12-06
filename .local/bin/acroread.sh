#!/usr/bin/bash

xhost +local:pedro
docker run  -v $HOME/Downloads/Torrents:/home/acroread/Documents:rw \
            -v /tmp/.X11-unix:/tmp/.X11-unix \
			--rm \
            -e uid=$(id -u) \
            -e gid=$(id -g) \
            -e DISPLAY=$DISPLAY \
            --name acroread \
            chrisdaish/acroread
xhost -local:pedro
