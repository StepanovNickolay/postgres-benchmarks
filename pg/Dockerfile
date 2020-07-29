ARG PG_SERVER_VERSION=11
FROM postgres:${PG_SERVER_VERSION}

ARG PG_SERVER_VERSION
ENV PG_SERVER_VERSION=${PG_SERVER_VERSION:-11}

RUN apt-get update \
#       && apt-get install --no-install-recommends -y curl \
       && apt-get install --no-install-recommends -y postgresql-server-dev-${PG_SERVER_VERSION} \
       && apt-get install --no-install-recommends -y postgresql-${PG_SERVER_VERSION}-hypopg \
       && apt-get install --no-install-recommends -y postgresql-${PG_SERVER_VERSION}-hypopg-dbgsym
#       && curl -L https://github.com/HypoPG/hypopg/archive/1.1.4.tar.gz | tar xz \
#       && cd hypopg-1.1.4 && make && make install
COPY init.sql /docker-entrypoint-initdb.d/
COPY wrapper.sh /
RUN chmod +x /wrapper.sh
ENTRYPOINT ["/wrapper.sh"]
CMD ["postgres", "-c", "logging_collector=on", "-c", "log_directory=/logs", "-c", "log_filename=postgresql.log", "-c", "log_statement=all"]