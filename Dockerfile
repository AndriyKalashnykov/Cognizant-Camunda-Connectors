# https://github.com/camunda/connectors/blob/main/connector-runtime/connector-runtime-application/example/Dockerfile
FROM camunda/connectors-bundle:8.7.0 AS runtime

# COPY ./azure-servicebus-connector/target/azure-servicebus-connector-3.0.0.jar /opt/app/
COPY ./target/azure-servicebus-connector-3.0.0-with-dependencies.jar /opt/app/azure-servicebus-connector.jar
