#!/bin/bash

image=plossys/vagrant-vcloud

if [ "$1" == "configure" ]; then
  shift
  docker run --rm -it --entrypoint retrieve-vagrant-vcloud-settings.sh "$image" "$@"
else
  docker run --rm -it \
    -v "$(pwd):/work" \
    -v ~/.vagrant.d/Vagrantfile:/user/Vagrantfile \
    -e VCLOUD_USER -e VCLOUD_PWD \
    "$image" "$@"
fi
