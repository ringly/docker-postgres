FROM postgres:9.3
MAINTAINER Peter Coles <peter@ringly.com>

# inspired by https://github.com/macadmins/postgres/blob/master/Dockerfile
# allows remote connections other than postgres to connect

ADD setupRemoteConnections.sh /docker-entrypoint-initdb.d/setupRemoteConnections.sh
RUN chmod 755 /docker-entrypoint-initdb.d/setupRemoteConnections.sh
