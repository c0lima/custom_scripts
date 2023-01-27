#!/bin/bash

while read line; do

app=$(echo $line | cut -d':' -f1)

redeploy=$(echo $line | cut -d':' -f2)

	if [ $redeploy = "true" ]; then
		echo "$(date +%d-%m-%y' '%R)   [!]   Redeploying script for $app ..."
		./redeploy.sh $app
		sed -i "s/$app: true/$app: false/" /srv/www/webhooks/redeployments
	fi

done < /srv/www/webhooks/redeployments 2>&1 | tee -a /var/log/redeploy/redeployments.log
