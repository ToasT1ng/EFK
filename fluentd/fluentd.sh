#!/bin/bash

SERVICE="fluentd"
PWD="$(pwd)"
LOG_PATH=""
FLUENTD_POS_PATH="${PWD}/pos"
FLUENTD_BUFFER_PATH="${PWD}/buffer"

function print_usage() {
/bin/cat << EOF

	Usage :
	    $0 [ -lp log_path ] [ -fp fluentd_pos_file_path ]
	Option :
	    -lp, --log_path, --log                    your log's path
	    -fp, --fluentd_pos_path                   your fluentd .pos file path
	    -h, --help                                print usages


EOF
}

while (( "$#" )); do
    case "$1" in
        -lp|--log_path|--log)
            if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
                LOG_PATH=$2
                shift 2
            else
                echo "Error: Argument for $1 is missing" >&2
                exit 1
            fi
            ;;
        -ldp|--log_dev_path|--log_dev)
            if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
                LOG_DEV_PATH=$2
                shift 2
            else
                echo "Error: Argument for $1 is missing" >&2
                exit 1
            fi
            ;;
        -fp|--fluentd_pos_path)
            if [ -n "$2" ] && [ ${2:0:1} != "-" ]; then
                FLUENTD_POS_PATH=$2
                shift 2
            else
                echo "Error: Argument for $1 is missing" >&2
                exit 1
            fi
            ;;
        -h|--help)
            print_usage
            exit 1
            ;;
        *)
            echo "Error: Arguments with not proper flag: $1" >&2
            echo "$0 -h for help message" >&2
            print_usage
            exit 1
            ;;
    esac
done

if [[ -z "$LOG_PATH" ]]
then
        echo "You need to input log_path. If you want more information, try   bash $0 -h"
        exit 1
fi

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
	sudo docker run -d --network elasticsearch_efk -e FLUENTD_CONF=fluentd.conf -v ${FLUENTD_BUFFER_PATH}:/var/buffer -v ${FLUENTD_POS_PATH}:/var/pos -v ${LOG_PATH}:/var/log --name ${SERVICE} toast1ng/${SERVICE}
	# -v /home/ubuntu/fluentd/buffer:/var/buffer
}
