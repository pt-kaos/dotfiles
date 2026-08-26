#!/usr/bin/bash

docker run -d \
  --name kali-linux \
  --security-opt seccomp=unconfined `#optional` \
  -e PUID=1000 \
  -e GUID=1000 \
  -e TZ="Europe/Lisbon" \
  -e SUBFOLDER=/ `#optional` \
  -e TITLE="Kali Linux" `#optional` \
  -p 3030:3000 \
  -p 3031:3001 \
  --device /dev/dri:/dev/dri `#optional` \
  --shm-size "1gb" `#optional` \
  --restart unless-stopped \
  lscr.io/linuxserver/kali-linux:latest
