FROM postgres:9.3
MAINTAINER Peter Coles <peter@ringly.com>

ADD fix-acl.sh /docker-entrypoint-initdb.d/
