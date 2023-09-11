FROM maven:3.6-jdk-11-slim as build
WORKDIR /app
COPY . .
#install jar files on local
RUN mvn install -DskipTests 

FROM openjdk:8-jdk-alpine
# openjdk:11-ea-17-jre-slim   we can use this image instead bcoz we only need runtime and artiifacts in the final image.
RUN addgroup aayush
RUN adduser -D aayush -G aayush
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar
USER aayush:aayush
CMD ["java", "-jar", "/app/app.jar"]
