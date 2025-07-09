# Use a Gradle image to build the project
FROM gradle:8.0.2-jdk17 AS build
WORKDIR /app

# Copy everything and build the project
COPY --chown=gradle:gradle . .
RUN gradle build --no-daemon

# Use a smaller JDK image to run the application
FROM eclipse-temurin:17-jdk
WORKDIR /app

# Copy the built JAR from the previous stage
COPY --from=build /app/build/
