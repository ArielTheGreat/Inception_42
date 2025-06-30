FROM debian:bullseye

# Install MariaDB with client tools
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean && \
    mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld && \
    rm -rf /var/lib/apt/lists/*

# Copy configuration and init scripts
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]
