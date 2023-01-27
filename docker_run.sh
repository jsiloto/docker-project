#!/bin/bash

############ Input Boilerplate ############
usage() { echo "Usage: $0 [-g <gpu>] [command]" 1>&2; exit 1; }

while getopts ":g:" o; do
    case "${o}" in
        g)
            g=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if  [ -z "${g}" ]; then
    usage
fi

################################################
echo "Using GPUS ${g}"
echo "Running as user: " $USER
echo "Startpoint: $1"

COMMAND="docker run --rm -it \
            --shm-size=32G  \
            -v $PWD:/work -w /work \
            -u $(id -u):$(id -g)  \
            --userns=host  \
	    --gpus='"device=${g}"' \
	    --userns=host  \
            --net=host \
            --name ${USER}.gpu${g}   \
            ${USER}/docker-image:latest $1"

eval "${COMMAND}"
