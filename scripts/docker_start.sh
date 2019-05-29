#!/bin/bash
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

label=$(<"$DIR/_label.docker")
var=$(<"$DIR/_id.docker")
if [ "$var" != "" ]
then
    bash "$DIR/docker_stop.sh"
fi
docker run -d -v "$DIR/../mounts/django_project":"/home/docker/code" $@ $label > "$DIR/_id.docker"
chmod 777 "$DIR/../mounts/django_project"
