# Use official Java 21 (lightweight)
FROM openjdk:21-jdk-slim

# Copy your JAR into the container
COPY target/sipmle-Api-0.0.1-SNAPSHOT.jar app.jar

# Run the app
ENTRYPOINT ["java", "-jar", "/app.jar"]