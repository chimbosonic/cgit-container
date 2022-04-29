# CGIT OCI image
![pipeline status](https://github.com/chimbosonic/cgit-container/actions/workflows/main.yml/badge.svg?branch=main)

This is a cgit OCI image built from https://git.zx2c4.com/cgit/.

Inspired by https://github.com/oemunoz/cgit.

Base image is ubuntu:focal and uses apache2 to run the server.

The image is available on Docker Hub [here](https://hub.docker.com/repository/docker/chimbosonic/cgit)

Source code and pipeline can be found [here](https://github.com/chimbosonic/cgit-container)

## Image Verification
The image is signed using [cosign](https://github.com/sigstore/cosign) from sigstore.

You can verify the signature with:
```bash
cosign verify --key cosign.pub chimbosonic/cgit:latest
```

## Running it
### plain docker
Feel free to change the port and folder that contains your repos.

```bash
docker run -it  --rm -p 80:80 -v /home/git:/mnt/git --name cgit chimbosonic/cgit:latest
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
## Misc
Image used to be stored and built at https://gitlab.com/chimbosonic/cgit-container that repo is now deprecated.
