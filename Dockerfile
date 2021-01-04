
#
# Build stage
#
FROM maven:3.5-jdk-8 AS buildStage
COPY src /home/src
COPY pom.xml /home
RUN mvn -f /home/pom.xml clean package

#
# Runtime stage
#
FROM gcr.io/distroless/java
COPY --from=buildStage /home/target/springbootexample-0.0.1-SNAPSHOT.jar /home/springbootexample-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","/home/springbootexample-0.0.1-SNAPSHOT.jar"]
