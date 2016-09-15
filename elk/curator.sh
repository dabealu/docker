#!/bin/bash
if [ -z $1 ] && [ -z $2 ]
  then
    echo -e "  Deletes logstash indexes \n  Usage: $0 <older-tnan> <time-units> \n  Example: $0 7 days"
    exit 1
  else
    docker run --rm --net=host webgears/curator --host localhost --port 9201 delete indices --older-than $1 --time-unit $2 --timestring '%Y.%m.%d'
fi
