## docker-sonarqube-mysql
sonarqube with mysql server as dock

## create mouunt directory 

```
sudo mkdir -p /opt/docker/sonarqube
sudo mkdir -p /opt/docker/sonarqube/app
sudo mkdir -p /opt/docker/sonarqube/app/conf
sudo mkdir -p /opt/docker/sonarqube/app/data
sudo mkdir -p /opt/docker/sonarqube/app/logs
sudo mkdir -p /opt/docker/sonarqube/mysql
```

# create docker-compose.yml and save into /opt/docker/sonarqube
```

version: '3'

services:
  mysql:
    image: mysql:5.7
    ports:
      - 3306:3306"
    environment:
      - MYSQL_ROOT_PASSWORD=root
      - MYSQL_DATABASE=sonarqube
    volumes:
      - /opt/docker/sonarqube/mysql

  sonarqube:
    image: sopheamak/sonarqube-docker
    ports:
      - "9000:9000"
    volumes:
      - /opt/docker/sonarqube/app/conf:/opt/sonarqube/conf
      - /opt/docker/sonarqube/app/data:/opt/sonarqube/data
      - /opt/docker/sonarqube/app/extensions:/opt/sonarqube/extensions
      - /opt/docker/sonarqube/app/logs:/opt/sonarqube/logs
    environment:
      - SONARQUBE_JDBC_URL=jdbc:mysql://mysql:3306/sonarqube?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance
      - SONARQUBE_JDBC_USERNAME=sonarqube
      - SONARQUBE_JDBC_PASSWORD=sonarqube
      - DATABASE_PORT=3306
      - DATABASE_HOST=mysql
    links:
      - mysql
  ```


## run docker-compose
```
cd /opt/docker/sonarqube/
docker-compose up
```

## log container
```
ysql_1      | Version: '5.7.20'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server (GPL)
mysql_1      | 2017-11-14T10:06:20.220050Z 0 [Note] Executing 'SELECT * FROM INFORMATION_SCHEMA.TABLES;' to get a list of tables using the deprecated partition engine. You may use the startup option '--disable-partition-engine-check' to skip this check. 
mysql_1      | 2017-11-14T10:06:20.220071Z 0 [Note] Beginning of list of non-natively partitioned tables
mysql_1      | 2017-11-14T10:06:20.273341Z 0 [Note] End of list of non-natively partitioned tables
sonarqube_1  | J
sonarqube_1  | 5.7.20*
....
se, or set useSSL=true and provide truststore for server certificate verification.
sonarqube_1  | 2017.11.14 10:07:50 INFO  ce[][o.s.s.p.ServerFileSystemImpl] SonarQube home: /opt/sonarqube
sonarqube_1  | 2017.11.14 10:07:50 INFO  ce[][o.s.c.c.CePluginRepository] Load plugins
sonarqube_1  | 2017.11.14 10:07:53 INFO  ce[][o.s.c.q.PurgeCeActivities] Delete the Compute Engine tasks created before Thu May 18 10:07:53 UTC 2017
sonarqube_1  | 2017.11.14 10:07:53 INFO  ce[][o.s.ce.app.CeServer] Compute Engine is operational
sonarqube_1  | 2017.11.14 10:07:54 INFO  app[][o.s.a.SchedulerImpl] Process[ce] is up
sonarqube_1  | 2017.11.14 10:07:54 INFO  app[][o.s.a.SchedulerImpl] SonarQube is up

```
