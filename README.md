# docker-ts3

A nice and easy way to get a TeamSpeak server up and running using docker. For
help on getting started with docker see the [official getting started guide][0].
For more information on TeamSpeak and check out it's [website][1].


## Build container (optional)

Running this will build you a docker image with the latest version of both
docker-ts3 and TeamSpeak itself.

    docker build https://github.com/ekrymov/docker-ts3.git
    
or

    git clone https://github.com/ekrymov/docker-ts3.git
    cd docker-ts3
    docker build -t ekrymov/docker-ts3 .


## Create container

Running the first time will set your port to a static port of your choice so
that you can easily map a proxy to. If this is the only thing running on your
system you can map the ports to 9987, 10011, 30033 and no proxy is needed. i.e.
`-p=9987:9987/udp  -p=10011:10011 -p=30033:30033` Also be sure your mounted
directory on your host machine is already created before running
`mkdir -p /mnt/teamspeak`.

    sudo docker run --name TS3 -d -p=9987:9987/udp -p=10011:10011 -p=30033:30033
    -v=/mnt/teamspeak:/data ekrymov/docker-ts3:latest /start

From now on when you start/stop docker-ts3 you should use the container id
with the following commands. To get your container id, after you initial run
type `sudo docker ps` and it will show up on the left side followed by the image
name which is `ekrymov/docker-ts3:latest`.

    sudo docker start <container_id>
    sudo docker stop <container_id>


## Server Admin Token

You can find the server admin token in /mnt/teamspeak/logs/, search the log
files for ServerAdmin privilege key created and use that token on first connect.


### Notes on the run command

 + `--name` is the container name (`TS3`)
 + `-v` is the volume you are mounting `-v=host_dir:docker_dir`
 + `ekrymov/docker-ts3` is simply what I called my docker build of this image
 + `-d` allows this to run cleanly as a daemon, remove for debugging
 + `-p` is the port it connects to, `-p=host_port:docker_port`

[0]: http://www.docker.io/gettingstarted/
[1]: http://teamspeak.com/
