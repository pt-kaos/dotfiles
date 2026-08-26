#!/usr/bin/bash

docker run \
  -d \
  --rm -it \
  --name it-tools \
  -p 8080:80 \
  corentinth/it-tools

