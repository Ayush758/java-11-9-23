FROM maven:3.6-jdk-11-slim as build
WORKDIR /app
COPY . .
RUN mvn install -DskipTests

FROM openjdk:8-jdk-alpine
# openjdk:11-ea-17-jre-slim   we can use this image instead bcoz we only need runtime and artiifacts in the final image.
RUN addgroup chaurasia
RUN adduser -D chaurasia -G chaurasia
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar
USER chaurasia:chaurasia
CMD ["java", "-jar", "/app/app.jar"]


# For springpet project from docker documentation
# FROM openjdk:17-alpine AS base
# WORKDIR /app
# COPY . .
# RUN ./mvnw install #bcoz openjdk doesn't have any such package called mvn that's why mvnw

# FROM openjdk:17-alpine
# RUN addgroup chaurasia && adduser -D chaurasia -G chaurasia
# WORKDIR /app
# COPY --from=base /app/target/*.jar /app/app.jar
# USER chaurasia:chaurasia
# CMD ["java", "-jar", "/app/app.jar"]
