# docker run --rm --name=azure-servicebus-connector \
#   -e ZEEBE_ADDRESS='localhost:26500' \
#   -e ZEEBE_CLIENT_ID='zeebe' \
#   -e ZEEBE_CLIENT_SECRET='zecret'\
#   -e CAMUNDA_OAUTH_URL='http://localhost:18080/auth/realms/camunda-platform/protocol/openid-connect/token' \
#   -e CAMUNDA_TASKLIST_BASE_URL='http://localhost:8082' \
#   -e CAMUNDA_OPERATE_BASE_URL='http://localhost:8081'  \
#   -e CAMUNDA_OPTIMIZE_BASE_URL='http://localhost:8083' \
#   -e CAMUNDA_MODELER_BASE_URL='http://localhost:8070/api' \
#   -e CAMUNDA_TENANT_ID='<default>' \
#   -e CAMUNDA_SECURE_CONNECTION=false \
#   azure-servicebus-connector:latest

cd ~/projects/Cognizant-Camunda-Connectors
mvn clean package install -DskipTests
cd ~/projects/Cognizant-Camunda-Connectors/azure-connectors/azure-servicebus-connector
mvn clean dependency:copy-dependencies package install shade:shade -DskipTests
cd ~/projects/Cognizant-Camunda-Connectors

docker run --rm --name=azure-servicebus-connector \
    -v /home/andriy/projects/azure-servicebus-connector/target/azure-servicebus-connector-3.0.0-with-dependencies.jar:/opt/app/connector.jar \
    -e ZEEBE_ADDRESS='localhost:26500' \
    -e ZEEBE_CLIENT_ID='zeebe' \
    -e ZEEBE_CLIENT_SECRET='zecret' \
    -e CAMUNDA_OAUTH_URL='http://localhost:18080/auth/realms/camunda-platform/protocol/openid-connect/token'\
    -e CAMUNDA_TASKLIST_BASE_URL='http://localhost:8082' \
    -e CAMUNDA_OPERATE_BASE_URL='http://localhost:8081'  \
    -e CAMUNDA_OPTIMIZE_BASE_URL='http://localhost:8083' \
    -e CAMUNDA_MODELER_BASE_URL='http://localhost:8070/api' \
    -e CAMUNDA_TENANT_ID='<default>' \
    -e CAMUNDA_SECURE_CONNECTION=false \
    camunda/connectors-bundle:8.7.0

# docker run --rm --name=connectors -v "/home/andriy/projects/camunda-alfresco-connector-rohwerj/target/document-base64-api-0.1.0-SNAPSHOT.jar":/opt/app/connector.jar --env-file env.txt camunda/connectors-bundle:0.2.0

# java -cp "/opt/app/*:/opt/custom/*"

# java -jar ~/projects/Cognizant-Camunda-Connectors/azure-connectors/azure-servicebus-connector/target/azure-servicebus-connector-3.0.0-with-dependencies.jar