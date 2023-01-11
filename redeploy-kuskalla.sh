#!/bin/sh

docker pull c0lima/plataforma-kuskalla:latest
docker stop plataforma-kuskalla
docker system prune -f
docker run -d -i -t -v /home/factoria/Desktop/plataforma-kuskalla/data:/webapp c0lima/plataforma-kuskalla:latest
