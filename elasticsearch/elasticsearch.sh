#!/bin/bash

SERVICE="elasticsearch"

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
#  sudo docker-compose -f docker-compose.yml up -d
  sudo docker-compose -f docker-compose.yml up --build -d
}
