# CGIT Container
![pipeline status](https://gitlab.com/chimbosonic/cgit-container/badges/master/pipeline.svg)

This is a cgit container compiled from https://git.zx2c4.com/cgit/.

Inspired by https://github.com/oemunoz/cgit.

Base image is ubuntu:latest and uses apache2 to run the server.

The image is available on Docker Hub [here](https://hub.docker.com/repository/docker/chimbosonic/cgit)

## Running it
### plain docker
Feel free to change the port and folder that contains your repos.

```bash
docker run -it  --rm -p 80:80 -v /home/git:/mnt/git --name cgit -t chimbosonic/cgit:latest
```

### docker-compose
Please read docker-compose.yml before running the following

```bash
docker-compose up -d
```

### How to build
This will build the container.

```bash
make build
```
