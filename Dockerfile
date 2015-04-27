FROM postgres:9.3
MAINTAINER Peter Coles <peter@ringly.com>

# inspired by https://github.com/macadmins/postgres/blob/master/Dockerfile

ENV DB_NAME ringly
ENV DB_USER postgres
ENV DB_PASS

ADD setupRemoteConnections.sh /docker-entrypoint-initdb.d/setupRemoteConnections.sh
RUN chmod 755 /docker-entrypoint-initdb.d/setupRemoteConnections.sh
ADD setup-database.sh /docker-entrypoint-initdb.d/
RUN chmod 755 /docker-entrypoint-initdb.d/setup-database.sh
