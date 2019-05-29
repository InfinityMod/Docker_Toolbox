# Docker_Toolbox

Linux environment to control docker containers more easy. 

Once initialized the scripts store and manage container-ids and commit-labels on its own. So you don't need to huddle around with this kind of stuff anymore. 

Currently only one running container per toolbox environment is supported. This means you need to copy a second instance of the repo and intialize this copy again if you want to run and control another container that based on the image than the first one. 

## First steps<br>
Clone and navigate to this repository.

First load your container-image by:<br>
*./scripts/docker_load_image.sh \<your_image_path>*

After loading the image you can start a new container-instance by:<br>
*./run_server.sh*

To get into the containers shell of the running instance run:<br>
*./run_shell.sh*

## Tool overview
*./run_server.sh* : runs the docker server

*./run_shell.sh* : navigates you into the shell of the running docker container

*./scripts/docker_start.sh * : creates a new instance with of the currently active image

./scripts/docker_stop.sh : shutdown current container

*./scripts/docker_stop_force.sh* : shutdown all container that have the same image name as the one that is currently active

*./scripts/docker_show_logs.sh*  : shows logs of the previous (if shutdown) or currently running docker container

*./scripts/docker_exec.sh  \<cmd>*:  executes a command in the running containers shell.

*./scripts/docker_commit.sh  \<message> \<commit_label>*:  commits the changes of the running container compared to the default container - image to keep them. 

*./scripts/docker_save_image.sh  \<name>* : saves the currently used image into a .tar file into folder './images'

*./scripts/docker_load_image.sh  \<path>* :  loads an image from a .tar file and uses it as default image on starting the docker container

*./scripts/docker_add_user.sh* :  if not yet done execute on first use of docker. Applies the current user to docker group to run a container withour root premission

*./scripts/docker_access_fs.sh* :  mounts and navigates you to the filesystem of the docker container to make modifications in your containers filesystem more easy (currently root access is unfortunately required).
