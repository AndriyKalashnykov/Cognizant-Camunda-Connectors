# https://hub.docker.com/_/maven/tags
FROM maven:3.9.9-eclipse-temurin-21 AS build

WORKDIR /opt/app

COPY . .
# COPY env.txt env.txt

RUN mvn clean dependency:copy-dependencies install shade:shade -DskipTests

# https://hub.docker.com/r/camunda/connectors-bundle/tags
FROM camunda/connectors-bundle:0.23.2 AS runtime
WORKDIR /opt/app

COPY --from=build /opt/app/azure-connectors/azure-servicebus-connector/target/*.jar connector.jar
COPY --from=build /opt/app/azure-connectors/azure-servicebus-connector/target/dependency/*.jar .
# COPY env.txt env.txt

CMD ["java", "-jar", "connector.jar"]