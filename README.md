# docker-project
General purpose docker boilerplate and cheat-sheet


# Build and Run
Most docker images by default run as root.
That may bring unintended consequences as files created within docker will have a root user.
To better manage this, this boilerplate provides scripts to build and run your docker container as your own user.

```bash
./docker_build.sh
./docker_run.sh
```

To change the image edit the `Dockerfile` file.