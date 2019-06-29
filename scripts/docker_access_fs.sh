#!/bin/bash
[ "$UID" -eq 0 ] || exec kdesu bash "$0" "$USER"

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"

id=$(<"$DIR/_id.docker")
label=$(<"$DIR/_label.docker")
pid=$(docker inspect --format {{.State.Pid}} $id)
folder="/proc/$pid/root/etc/.."
mnt_folder="$DIR/../mounts/root/"

mkdir -p "$mnt_folder"
sudo umount "$mnt_folder"
sudo bindfs --map=root/$1 "$folder" "$mnt_folder"

. "$DIR/_init.sh"

if testcmd xdg-open; then
    xdg-open "$mnt_folder"
else
    cd "$mnt_folder"
fi
