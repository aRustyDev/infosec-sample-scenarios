FROM mysql
COPY ./scripts/mysql.sh /opt/scripts/mysql.sh
ENV MYSQL_DATABASE=default
ENV MYSQL_USER=mysql
ENV MYSQL_ROOT_PASSWORD=p@ssw0rd
ENV MYSQL_PASSWORD=p@ssw0rd
RUN chmod 744 /opt/scripts/mysql.sh && /opt/scripts/mysql.sh