#!/bin/bash

mysql_host=${DATABASE_HOST}
mysql_port=${DATABASE_PORT}

echo " $mysql_host $mysql_port"

shift 2
cmd="$@"
# wait for the mysql docker to be running
while ! nc $mysql_host $mysql_port; do
  echo "mysql is unavailable - sleeping 1"
  sleep 10
done

>&2 echo "mysql is up executing command"
# run the command
exec $cmd


set -e

if [ "${1:0:1}" != '-' ]; then
  exec "$@"
fi



chown -R sonarqube:sonarqube $SONARQUBE_HOME
exec gosu sonarqube \
  java -jar lib/sonar-application-$SONAR_VERSION.jar \
  -Dsonar.log.console=true \
  -Dsonar.jdbc.username="$SONARQUBE_JDBC_USERNAME" \
  -Dsonar.jdbc.password="$SONARQUBE_JDBC_PASSWORD" \
  -Dsonar.jdbc.url="$SONARQUBE_JDBC_URL" \
  -Dsonar.web.javaAdditionalOpts="$SONARQUBE_WEB_JVM_OPTS -Djava.security.egd=file:/dev/./urandom" \
