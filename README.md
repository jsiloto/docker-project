# docker-project
General purpose docker boilerplate and cheat-sheet


## Build and Run
Most docker images by default run as root.
That may bring unintended consequences as files created within docker will have a root user.
To better manage this, this boilerplate provides scripts to build and run your docker container as your own user.

```bash
./docker_build.sh
./docker_run.sh -g 0
```

To change the image edit the `Dockerfile` file.

### Managing your Container
Lets check a container lifetime example
```bash
./docker_run.sh -g 0
# Detach from your container by pressing Ctrl+p-q
# Check your container exists
docker ps
# List all images
docker images
# Reattach to your container
docker attach <your container name(use tab)>
```

Now Open another Terminal
```bash
# You can run multiple processes in your container
docker exec -it <your container name(use tab)> /bin/bash
# Kill your process
# Ctrl+C
# Kill your container
docker kill <your container name(use tab)>
# Check your container no longer exists
docker ps
```

## Running with arguments
The last argument in the docker run command is optional
and provides you the starting binary of your command application
(usually `\bin\bash`)

Try:
```bash
./docker_run.sh -g 0 'jupyter notebook --no-browser -NotebookApp.token='ABC''
```


## Running without ./docker_run.sh
### Managing GPUs and CPUs
https://docs.docker.com/config/containers/resource_constraints/
```bash
docker run --rm -it --gpus='"device=0,1"' --cpus=2.3 --memory=1GB ${USER}/docker-image
```

### Using the disk
```bash
#docker run --rm -it -v local_path:container_path ${USER}/docker-image
docker run --rm -it -v $PWD:/work ${USER}/docker-image
```

### Networking
```bash
docker run --rm -it --net=host ${USER}/docker-image \
 jupyter notebook --no-browser -NotebookApp.token='ABC'

docker run --rm -it -p 8123:8888 ${USER}/docker-image \
 jupyter notebook --ip 0.0.0.0 --no-browser -NotebookApp.token='ABC'
```

### DockerHub
You can do the same thing we did building a custom image 
by exploring existing images in the community.
In this case `jupyter/datascience-notebook`

```bash
docker run --rm -it --network host  -v $PWD:/work -w /work jupyter/datascience-notebook jupyter notebook --no-browser -NotebookApp.token='ABC'
```

Check out more at https://hub.docker.com/