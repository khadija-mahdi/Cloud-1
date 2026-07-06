FROM debian:bullseye

RUN apt update -y \
    && apt install -y --no-install-recommends mariadb-server \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 3306

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/script.sh /usr/local/bin/script.sh

RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT ["sh", "/usr/local/bin/script.sh"]
