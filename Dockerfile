#################################################################
# Ubuntu 14.04 with added Teamspeak 3 Server.
# Uses SQLite Database on default.
#
# Builds a basic docker image that can run TeamSpeak
# (http://teamspeak.com/).
#
# Authors: Eugene Krymov
# Updated: Oct 04th, 2015
# Require: Docker (http://www.docker.io/)
#################################################################

# Base system is the LTS version of Ubuntu.
FROM  ubuntu:14.04

# Make sure we don't get notifications we can't answer during building.
ENV   DEBIAN_FRONTEND noninteractive

## Set some variables for override
# Teamspeak Server version
ENV   TEAMSPEAK_VERSION 3.0.11.4
# Download Link of Teamspeak 3 Server
ENV   TEAMSPEAK_URL http://dl.4players.de/ts/releases/${TEAMSPEAK_VERSION}/teamspeak3-server_linux-amd64-${TEAMSPEAK_VERSION}.tar.gz

# Download and install everything from the repos.
RUN   apt-get --yes update; apt-get --yes upgrade

# Download and install TeamSpeak 3
ADD   ${TEAMSPEAK_URL} /opt/
RUN   cd /opt; tar -zxf teamspeak3-server_linux-amd64-3.*.tar.gz; rm teamspeak3-server_linux-amd64-3.*.tar.gz

# Load in all of our config files.
ADD   ./scripts/start /start

# Fix all permissions
RUN   chmod +x /start

ENTRYPOINT  ["/start"]

# Expose the Standart TS3 port.
EXPOSE 9987/udp
# for ServerQuery
EXPOSE 10011
# for files
EXPOSE 30033

# Inject a Volume for any TS3-Data that needs to be persisted 
# or to be accessible from the host. (e.g. for Backups)
VOLUME ["/data"]
