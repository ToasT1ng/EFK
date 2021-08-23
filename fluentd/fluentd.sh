#!/bin/bash

SERVICE="fluentd"

CONTAINER_ID=$(sudo docker ps -a -f "name=${SERVICE}" -q)
if [ -z "$CONTAINER_ID" ] ; then
   echo "Nothing!"
else
   echo "Container kill"
   sudo docker commit -a "jane" -m "lastVersion" ${SERVICE} toast1ng/${SERVICE}:lastversion
   sudo docker container kill $CONTAINER_ID
   sudo docker container rm $CONTAINER_ID
fi

echo "start"
{
  sudo docker build -f Dockerfile -t toast1ng/${SERVICE} .
	sudo docker run -d -p 8888:8888 -e FLUENTD_CONF=fluentd.conf --name ${SERVICE} toast1ng/${SERVICE}
	# -v /home/ubuntu/fluentd/buffer:/var/buffer -v /home/ubuntu/fluentd/pos:/var/pos -v /home/ubuntu/spring/log:/var/log -v /home/ubuntu/spring/log_dev:/var/log_dev
}
