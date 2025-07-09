# Stage 1: Build with Gradle
FROM gradle:8.0.2-jdk17 AS builder
WORKDIR /app

# Copy everything into the container
COPY . .

# Build the project
RUN gradle build --no-daemon

# Stage 2: Run the application with a smaller image
FROM eclipse-temurin:17-jdk
WORKDIR /app

# Copy the built jar file from the builder stage
COPY --from=builder /app/build/libs/*.jar app.jar

# Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]
