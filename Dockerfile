# Base image
FROM eclipse-temurin:17-jdk

# Set working directory
WORKDIR /app

# Copy WAR file built by Maven
COPY target/NETFLIX.war /app/webapp.war

# Expose port
EXPOSE 8080

# Run WAR
CMD ["java", "-jar", "/app/webapp.war"]


