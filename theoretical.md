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
