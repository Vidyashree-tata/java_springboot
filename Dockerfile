# Stage 1: Build the project
FROM openjdk:21-jdk-slim as builder

WORKDIR /trans_planner

COPY . .

# Ensure gradlew is executable
RUN chmod +x ./gradlew

# Build the project
RUN ./gradlew build -x test

RUN ls -l /trans_planner/build/libs/

# Stage 2: Build the final image
FROM openjdk:21-jdk-slim

WORKDIR /trans_planner

# Copy the generated JAR dynamically and rename it to trans_planner.jar
COPY --from=builder /trans_planner/build/libs/TransMoney-0.0.1-SNAPSHOT.jar trans_planner.jar

EXPOSE 8085

ENTRYPOINT ["java", "-jar", "trans_planner.jar"]
