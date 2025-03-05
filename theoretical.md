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

## Two types of external storage in Docker:

### 1. Volumes: managed by Docker and stored in a part of the host file system:

* **Anonymous** volumes: created and managed by Docker

    ```Dockerfile
    VOLUME ['/app/data']
    ``` 
* **Named** volumes: created and managed by Docker with a specific name
    ```bash
    docker volume create <volume-name>
    docker run -v <volume-name>:<path> <image-name>:<tag>
    ```      

- **Anonymous** volumes are created automatically when you run a container with a VOLUME instruction in the Dockerfile.
  It will be created in the /var/lib/docker/volumes directory on the host file system, and deleted when the container is
  removed.

- **Named** volumes are created manually using the docker volume create command.
  It will be created in the /var/lib/docker/volumes directory on the host file system, and not deleted when the
  container is removed.

### 2. Bind mounts: stored anywhere on the host file system:

- Managed by the user.
- Bind mounts are created using the -v or --mount flag when running a container.
- Used to share files between the host and the container.
- Great for persistent data that needs to be shared between containers or stored on the host file system.
- Bind mounts can be read-write or read-only.
- Great for editable files like code files, configuration files, and other files that need to be shared between the host
  and the container.

```bash
docker run -v <host-path>:<container-path> <image-name>:<tag>
```

### Comparing Volumes and Bind Mounts:

| Feature                               | Anonymous Volumes                               | Named Volumes                                        | Bind Mounts                                       |
|---------------------------------------|-------------------------------------------------|------------------------------------------------------|---------------------------------------------------|
| **Created & Managed By**              | Docker                                          | Docker                                               | User                                              |
| **Used By**                           | One container                                   | One or more containers                               | Host and container (shared)                       |
| **Deleted When Container is Removed** | Yes                                             | No                                                   | No                                                |
| **Shared Between Containers**         | No                                              | Yes                                                  | Yes                                               |
| **Accessible from Host File System**  | No                                              | Yes                                                  | Yes                                               |
| **Example Use Case**                  | Temporary data storage, databases in containers | Persistent data storage, databases across containers | Host file system interaction, configuration files |
| **Performance**                       | High, optimized by Docker                       | High, optimized by Docker                            | Performance depends on host system                |
| **Flexibility**                       | Limited to the container's lifecycle            | Can be backed up or shared easily                    | Full control over the file system                 |

### Volume commands:

* list all volumes:

```bash
docker volume ls
```

* inspect a volume:

```bash
docker volume inspect <volume-name>
```

* remove a volume:

```bash
docker volume rm <volume-name>
```

* remove all volumes:

```bash
docker volume rm $(docker volume ls -q)
```

# ENV and ARG

## ENV:

It is used to set environment variables in the image that can be accessed by the container.

```Dockerfile
ENV <key>=<value>
```

* ex:

```Dockerfile
ENV NODE_ENV=production
```

```bash
docker run -e NODE_ENV=development <image-name>:<tag> 
docker run --env-file <env-file-path> <image-name>:<tag>
```

* to access the environment variable in the container, you can use the `process.env` object in Node.js:

```javascript
console.log(process.env.NODE_ENV);
```

## ARG:

It is used to pass arguments to the Dockerfile when building an image.

```Dockerfile
ARG <key>=<value>
```

* ex:

```Dockerfile
ARG NODE_VERSION=14
```

# Networking in Docker

* It is used to connect containers to each other and to the outside world.
* There are three types of communication:
    1) **Container to container**: containers can communicate with each other using their IP addresses.
    2) **Container to host**: containers can communicate with the host machine using the host IP address.
    3) **Container to the outside world**: containers can communicate with the outside world using the host IP
       address.

##  Networking app:
    
    docker run --rm --env-file env -p 3000:3000 -v "/home/hany_jr/Backend/docker-learn/Networking:/app" -v /app/node_modules 2c2e33c0391a

When you will run the above command, you will see the following output:

```bash
MongoNetworkError: failed to connect to server [127.0.0.1:27017] on first connect [Error: connect ECONNREFUSED 127.0.0.1:27017
```
* This error is because the container is trying to connect to the host machine, but there is no connection between them.
* Networks will solve this problem.

### For container to host communication:
    
    replace the host with the IP address of the host machine.
    localhost to host.docker.internal

## Network commands:

* list all networks:
```bash
docker network ls
```

* inspect a network:
```bash
docker network inspect <network-name>
```

* create a network:
```bash
docker network create <network-name>
```

* connect a container to a network:
```bash
docker network connect <network-name> <container-name>
```

* disconnect a container from a network:
```bash
docker network disconnect <network-name> <container-name>
```

* remove a network:
```bash
docker network rm <network-name>
```

* remove all networks:
```bash
docker network rm $(docker network ls -q)
```
NOTE:
    In the networks, the container name will be translated to the container IP address.


# Multi-container applications

`Lock at multi_dockerizing dir`

## App demo:

### There are 3 parts of the app:

1. **Client**: a React app that displays a form to the user.
2. **Server**: a Node.js app that receives the form data from the client and sends it to the worker.
3. **MongoDB**: a database that stores the form data.

### Requirements:
1. **MongoDB**: 
   * Data Must be persistent.
   * Access should be limited to the server only.

2. **Server**:
   * Must be able to communicate with the client and the worker.
   * Must be able to store data in the database.
   * Log’s file should be persistent.
   * Live source code should be shared with the host

3. **Client**
    * Must be able to communicate with the server.
    * Live source code should be shared with the host


