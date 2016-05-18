#!/usr/bin/env bash

# doing this here (in an async way)
docker stop bsimm-web &

echo "Creating Docker image for BSIMM-Graph"

docker build -t bsimm-graph ./docker-images/1.base-image/.
docker build -t bsimm-graph ./docker-images/2.git-pull/.

echo "Stopping bsimm-web container"
docker rm bsimm-web
docker run --name bsimm-web -it -p 3000:3000 -d bsimm-graph

#open http://192.168.99.100:3000

docker ps


