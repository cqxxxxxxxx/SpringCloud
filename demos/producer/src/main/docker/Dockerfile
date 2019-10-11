FROM java:alpine
VOLUME /tmp
ADD producer-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT exec java $JAVA_OPTS -jar /app.jar
