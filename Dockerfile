#FROM maven:3.10-eclipse-temurin-25-alpine AS build
#WORKDIR /app
#COPY pom.xml .
#RUN mvn dependency:go-offline -B
#COPY src ./src
#RUN mvn clean package -DskipTests
#FROM eclipse-temurin:25-jre-alpine
#WORKDIR /app
#COPY --from=build /app/target/*.jar app.jar
#ENTRYPOINT ["java", "-jar", "app.jar"]


# Stage 1: Build application
FROM maven:3.9-eclipse-temurin-25 AS build
WORKDIR /app
COPY . .
RUN chmod +x mvnw
RUN ./mvnw clean package -DskipTests

# Stage 2: Run application
FROM eclipse-temurin:25-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
