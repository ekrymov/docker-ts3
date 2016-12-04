#################################################################
# Ubuntu 16.04 with added Teamspeak 3 Server.
# Uses SQLite Database on default.
#
# Builds a basic docker image that can run TeamSpeak
# (http://teamspeak.com/).
#
# Authors: Eugene Krymov
# Updated: Dec 04th, 2016
# Require: Docker (http://www.docker.io/)
#################################################################

# Base system is the LTS version of Ubuntu.
FROM ubuntu:16.04

# Make sure we don't get notifications we can't answer during building.
ENV DEBIAN_FRONTEND noninteractive

## Set some variables for override
# Teamspeak Server version
ENV TS_VERSION 3.0.13.6
# Download Link of Teamspeak 3 Server
ENV TS_URL http://dl.4players.de/ts/releases/${TS_VERSION}/teamspeak3-server_linux_amd64-${TS_VERSION}.tar.bz2

# Download and install everything from the repos.
RUN apt-get update; apt-get upgrade -y
RUN apt-get install bzip2 -y
RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Download and install TeamSpeak 3
ADD ${TS_URL} /opt/ts3.tar.bz2
RUN cd /opt; tar -jxf ts3.tar.bz2; rm ts3.tar.bz2

# Load in all of our config files.
ADD ./scripts/start /start

# Fix all permissions
RUN chmod +x /start

#ENTRYPOINT ["/start"]

# Expose the Standart TS3 port.
EXPOSE 9987/udp
# for ServerQuery
EXPOSE 10011
# for files
EXPOSE 30033

# Inject a Volume for any TS3-Data that needs to be persisted 
# or to be accessible from the host. (e.g. for Backups)
VOLUME ["/data"]

# Start TS3 Server
CMD ["/start"]
