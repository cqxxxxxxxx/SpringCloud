FROM java:alpine
VOLUME /tmp
ADD admin-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT exec java $JAVA_OPTS -jar /app.jar
