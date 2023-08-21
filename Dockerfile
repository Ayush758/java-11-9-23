FROM maven:3.6-jdk-11-slim as build
WORKDIR /app
COPY . .
RUN mvn install -DskipTests

FROM openjdk:8-jdk-alpine
RUN addgroup chaurasia
RUN adduser -D chaurasia -G chaurasia
WORKDIR /app
COPY --from=build /app/target/*.jar /app/app.jar
USER chaurasia:chaurasia
CMD ["java", "-jar", "/app/app.jar"]
