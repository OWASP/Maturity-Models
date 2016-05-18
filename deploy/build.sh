#!/usr/bin/env bash

echo "Creating Docker image for BSIMM-Graph"

docker build -t bsimm-graph ./docker-images/1.base-image/.
docker build -t bsimm-graph ./docker-images/2.git-pull/.

#docker rm bsimm-web
#docker run --name bsimm-web -it -p 3000:3000 bsimm-graph


