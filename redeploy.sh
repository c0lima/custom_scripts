#!/bin/sh

################
#### ROUTES ####
################

plataforma_kuskalla="/srv/www/kuskalla/"

if [ $1 = "plataforma_kuskalla" ]; then folder=$plataforma_kuskalla; fi

###############
### REDEPLOY ##
###############


for app in "$@"; do
	docker pull c0lima/$app:latest
	docker stop $app
	docker system prune -f
	( cd $folder; docker compose up -d )

done

