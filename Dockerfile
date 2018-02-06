# Start from GridGain Professional image.
FROM gridgain/gridgain-pro:2.1.8

# Set config uri for node.
ENV CONFIG_URI MyIgniteCluster-server.xml

# Copy ignite-http-rest from optional.
ENV OPTION_LIBS ignite-rest-http

# Update packages and install maven.
RUN \
   apt-get update &&\
   apt-get install -y maven

# Append project to container.
ADD . MyIgniteCluster

# Build project in container.
RUN mvn -f MyIgniteCluster/pom.xml clean package -DskipTests

# Copy project jars to node classpath.
RUN mkdir $IGNITE_HOME/libs/MyIgniteCluster && \
   find MyIgniteCluster/target -name "*.jar" -type f -exec cp {} $IGNITE_HOME/libs/MyIgniteCluster \;