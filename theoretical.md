# what is image and containers?

## Image

- is a template for creating a container.
- contains the application, libraries, and dependencies needed to run the application.
- it is a read-only file system that includes everything needed to run an application.

## Container

- it is the run time of an image.
- we can create multiple containers from a single image.
- containers are isolated from each other and from the host environment.
- is a running instance of an image, it is a lightweight and portable encapsulated environment that runs applications.

# How to create an image?

there are two ways to create an image:

1. **pull an image from a registry**: you can pull an image from a public registry like Docker Hub or a private
   registry.
2. **build an image using a Dockerfile**: you can create an image using a Dockerfile, which is a text file that contains
   a set of instructions for building an image.

## Pull an image from a registry

- to pull an image from a registry, you can use the `docker pull` command followed by the name of the image you want to
  pull.

```bash
docker pull <image-name><tag> || docker run <image-name>:<tag> 
```

#### ex:

```
docker run node:14
```

## Building a custom image using a Dockerfile

- in the root directory of your project, create a file named `Dockerfile` with the following content:

```Dockerfile   
# To get the base image use FROM
# FROM <image-name>:<tag>
FROM node:14

# To set the working directory and be the root directory for all subsequent instructions use WORKDIR
WORKDIR /app

# To copy files from the host machine to the image use COPY
# COPY <source> <destination>
COPY . /app
# To run a command inside the container use RUN while building the image
# RUN <command>
RUN npm install

# To expose a port use EXPOSE
# EXPOSE <port>    
EXPOSE 3000

# To set an environment variable use ENV
# ENV <key>=<value>
ENV NODE_ENV=production

# To specify the command to run when the container starts use CMD or ENTRYPOINT
# CMD ["<command>", "<arg1>", "<arg2>"]
# ENTRYPOINT ["<command>", "<arg1>", "<arg2>"] to be used when you want to run the same command every time the container starts
ENTRYPOINT ["node", "/app/index.js"]
CMD ["node", "/app/index.js"]
```

#### See `problem-4` dir for more details

# Managing images and containers

### Images

* list all images

```bash
docker images
    options:
        -a: list all images
        -q: list only the image IDs
```

* Removing an image

    * removing an image by name:
        ```bash
        docker rmi <image-name>:<tag>
        ```
    * removing an image by ID:
        ```bash
        docker rmi <image-id>
        ```
    * removing all images:
        ```bash
        docker rmi $(docker images -q)
        ```
* Building an image

    * building an image from a Dockerfile:
        ```bash
        docker build -t <image-name>:<tag> <path-to-dockerfile>
        ```
    * building an image from a Dockerfile in the current directory:
        ```bash
        docker build -t <image-name>:<tag> .
        ```
    * building an image with a specific build context:
        ```bash
        docker build -t <image-name>:<tag> -f <path-to-dockerfile> <build-context>
        ```
* Tagging an image

    * tagging an image with a new name:
        ```bash
        docker tag <image-id> <new-image-name>:<tag>
        ```
    * tagging an image with a new name and a registry:
        ```bash
        docker tag <image-id> <registry>/<new-image-name>:<tag>
        ```

* Pushing an image to a registry

    * pushing an image to a registry with a specific tag:
        ```bash
        docker push <image-name>:<tag>
        ```
    * pushing an image to a registry with a specific tag and registry:
        ```bash
        docker push <registry>/<image-name>:<tag>
        ```

* Pulling an image from a registry

    * pulling an image from a registry with a specific tag:
        ```bash
        docker pull <image-name>:<tag>
        ```
    * pulling an image from a registry with a specific tag and registry:
        ```bash
        docker pull <registry>/<image-name>:<tag>
        ```

### Containers

* list all running containers

```bash
docker ps
    options:
        -a: list all containers
        -q: list only the container IDs
        -l: list the last container that was run
        -s: display the total file size
```

* Running a container
    * Attached and Detached mode:

      by default, when you run a container, it runs in the foreground, and you can see the output of the container.
      it is called attached mode.

        * attached mode:
          ```bash
          docker run <image-name>:<tag>
          ```

        * detached mode:
            ```bash
            docker run -d <image-name>:<tag>
            ```

    * Naming a container:
        ```bash
        docker run --name <container-name> <image-name>:<tag>
        ```
    * port mapping:
        ```bash
        docker run -p <host-port>:<container-port> <image-name>:<tag>
        ```

* Starting and Stopping a container

    * stopping a running container:
        ```bash
        docker stop <container-id> || <container-name>
        ```
    * starting a stopped container (the container must be stopped and not removed):
        ```bash
        docker start <container-id> || <container-name>
        ```          
* Removing a container

    * removing a stopped container:
        ```bash
        docker rm <container-id> || <container-name>
        ```
    * removing a running container:
        ```bash
        docker rm -f <container-id> || <container-name>
        ```
    * removing all containers (both running and stopped):
        ```bash
        docker rm $(docker ps -a -q)
        ```
    * removing containers after we exit from them:
        ```bash
        docker run --rm <image-name>:<tag>
        ```      

# Managing Data and Working with Volumes

## Type of data in Docker:

1. application data: the data that the application uses to run:
   * Code files, configuration files, and other files that the application needs to run.
   * This data is stored in the image and is read-only (fixed).

2. Temporary data: the data that the application generates while running:
   * Logs, cache, and other temporary files that the application generates while running.
   * This data is stored in the container and is lost when the container is removed.

3. Persistent data: the data that the application needs to store permanently:
   * Database files, user uploads, and other data that the application needs to store permanently.
   * This data is stored outside the container and is persistent.
    * Stored in volumes or bind mounts.
