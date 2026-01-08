# Base image
FROM openjdk:17-jdk

# Set working directory
WORKDIR /app

# Copy WAR file
COPY target/NETFLIX.war /app/webapp.war

# Expose port for Tomcat / Spring Boot
EXPOSE 8080

# Run WAR
CMD ["java", "-jar", "/app/webapp.war"]

