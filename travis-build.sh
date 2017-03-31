#!/bin/bash
docker build -t tmp -f Dockerfile.build .
docker rm -f tmp
docker create --name tmp tmp
docker cp tmp:/src/vagrant-vcloud-0.4.7.1.gem .
docker build -t plossys/vagrant-vcloud:build -f Dockerfile .
