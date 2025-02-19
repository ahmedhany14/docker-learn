# 1. pull container from docker hub

    docker container run -d <container_name>:<tag> # to run the container in detached mode
    docker container run -d --name <container_name> <container_name>:<tag> # to name the container while running
    docker container run -d -p 3000:80 --name <container_name> <container_name>:<tag> # to map port 80 to 3000 in the host machine
    docker container run -it --name <container_name> <container_name>:<tag> # to run the container in interactive mode

# 2. just pull image from docker hub

    docker image pull <image_name>:<tag>

# 3. stop|start|restart|remove container

    docker container stop <container_name>
    docker container start <container_name>
    docker container restart <container_name>
    docker container rm <container_name>
    docker container rm -f <container_name> # to force remove the container even if it is running

# 4. list all containers and images

    docker container ls
    docker container ls --all # to list all containers even if they are not running
    docker image ls

# 5. work with unofficial images

    docker container run -d --name <container_name> <username>/<image_name>:<tag> # to run the container from unofficial image
    docker image pull <username>/<image_name>:<tag> # to pull the image from unofficial image

# 6. explore the image

    docker image ls --digests alpine # to list all the digests of the alpine image
    docker image inspect alpine # to inspect the alpine image, to see the layers and other details like environment variables, ip address etc.
    docker manifest inspect <image_name>:<tag> # to inspect the manifest of the image, like architecture, os etc.

# 8. delete images and containers

    docker image rm <image_name or id> # to remove the image
    docker image rm -f <image_name or id> # to force remove the image
    docker image ls -q # to list only the image ids
    docker image rm $(docker image ls -q) # to remove all the images

# 9. container interaction with name

1. make the container interact with another container using the name
  
        docker container run -it --name <container_name> --add-host<other_container_name> <image_name>:<tag> 
- for example, if nginx container is running, and we want to make the alpine container interact with the nginx container

# 10. network

    docker network ls # to list all the networks
    docker network inspect bridge # to inspect the bridge network
    docker network create <network_name> # to create a new network
    docker network rm <network_name> # to remove the network
    docker network create --internal <network_name> # to create an internal network which will not have access to the outside world
    docker network connect <network_name> <container_name> # to connect the container to the network
    docker network disconnect <network_name> <container_name> # to disconnect the container from the network
    docker container run -d --name <container_name> --network <network_name> <image_name>:<tag> # to run the container in a specific network
    docker container run -d --name <container_name> --network host <image_name>:<tag> # to run the container in host network
    docker container run -d --name <container_name> --network none <image_name>:<tag> # to run the container in no network

- it is important to note that the container in host network will not have the network isolation, it will share the host network.
- the container in none network will not have any network access.
- containers in the same network can communicate with each other using the container name.
    

# 11. copy files from host machine to container and vice versa

    docker container cp <file_path> <container_name>:<container_path> # to copy the file from host to container
    docker container cp <container_name>:<container_path> <file_path> # to copy the file from container to host
* example: 

        docker container cp /file.txt alpine:/tmp/file.txt
this approach has a bad side which is when you modify a file in the host machine, it will not be reflected in the container, so you have to copy it again. (will solve it in a storage section)

# 12. storage

    docker container run -d --name <container_name> -v <full host_path>:<container_path> <image_name>:<tag> # to mount a volume from the host machine to the container, so the file will be reflected in both the host and the container
    docker volume create <volume_name> # to create a volume in the docker host
    docker volume ls # to list all the volumes
    docker volume inspect <volume_name> # to inspect the volume
    docker volume rm <volume_name> # to remove the volume
    docker container run -d --name <container_name> -v <volume_name>:<paht_in_container> <image_name>:<tag> # to mount a volume to the container which is created in the docker host and it will be reflected in both the host and the container

# 13. create new images from modified container

* after you run the image and add some apps or your code, you need to save the current state in a new image to use it later

    docker commit <container_name> <new_image_name>:<tag>