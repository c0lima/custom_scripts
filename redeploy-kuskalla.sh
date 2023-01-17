#!/bin/sh

docker pull c0lima/plataforma-kuskalla:latest
docker stop plataforma-kuskalla
docker system prune -f
cd /srv/www/kuskalla.cplus.cl & docker compose up -d
