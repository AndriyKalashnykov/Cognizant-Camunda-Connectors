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

# cd ~/projects/Cognizant-Camunda-Connectors
# mvn clean package install -DskipTests
# cd ~/projects/Cognizant-Camunda-Connectors/azure-connectors/azure-servicebus-connector
# mvn clean dependency:copy-dependencies package install shade:shade -DskipTests
# cd ~/projects/Cognizant-Camunda-Connectors

docker run --rm --name=azure-servicebus-connector \
    -v /home/andriy/projects/azure-servicebus-connector/target/azure-servicebus-connector-3.0.0-with-dependencies.jar:/opt/app/connector.jar \
    -e CAMUNDA_CLIENT_MODE=self-managed \
    -e CAMUNDA_CLIENT_ZEEBE_REST-ADDRESS=http://localhost:8080 \
    -e CAMUNDA_CLIENT_ZEEBE_GRPCADDRESS=http://localhost:26500 \
    -e CAMUNDA_CLIENT_ZEEBE_RESTADDRESS=http://localhost:8080 \
    -e OPERATE_CLIENT_BASEURL=http://localhost:8081 \
    -e OPERATE_CLIENT_PROFILE=oidc \
    -e OPERATE_CLIENT_AUTHURL=http://localhost:18080/auth/realms/camunda-platform/protocol/openid-connect/token \
    -e OPERATE_CLIENT_AUDIENCE=operate-api \
    -e OPERATE_CLIENT_CLIENTID=connectors \
    -e OPERATE_CLIENT_CLIENTSECRET=XALaRPl5qwTEItdwCMiPS62nVpKs7dL7 \
    -e ZEEBE_ADDRESS=localhost:26500 \
    -e ZEEBE_CLIENT_BROKER_GATEWAY-ADDRESS=localhost:26500 \
    -e ZEEBE_CLIENT_SECURITY_PLAINTEXT=true \
    -e ZEEBE_CLIENT_ID=zeebe \
    -e ZEEBE_CLIENT_SECRET=zecret \
    -e ZEEBE_CLIENT_CONFIG_PATH=/tmp/zeebe_auth_cache \
    -e ZEEBE_CLIENT_WORKER_STREAM_ENABLED=false \
    -e ZEEBE_TOKEN_AUDIENCE=zeebe-api \
    -e ZEEBE_AUTHORIZATION_SERVER_URL=http://localhost:18080/auth/realms/camunda-platform/protocol/openid-connect/token \
    -e CAMUNDA_IDENTITY_ISSUER_URL=http://localhost:18080/auth/realms/camunda-platform \
    -e CAMUNDA_IDENTITY_ISSUER_BACKEND_URL=http://localhost:18080/auth/realms/camunda-platform \
    -e CAMUNDA_IDENTITY_CLIENT_ID=connectors \
    -e CAMUNDA_IDENTITY_CLIENT_SECRET=XALaRPl5qwTEItdwCMiPS62nVpKs7dL7 \
    -e CAMUNDA_IDENTITY_TYPE=KEYCLOAK \
    -e CAMUNDA_IDENTITY_AUDIENCE=operate-api \
    camunda/connectors-bundle:8.7.0

    # -e camunda.client.mode='simple' \
    # -e camunda.client.auth.username='demo' \
    # -e camunda.client.auth.password='demo' \
    # -e zeebe.client.broker.gateway-address='127.0.0.1:26500' \
    # -e zeebe.client.security.plaintext='true' \
    # -e camunda.operate.client.profile='simple' \
    # -e camunda.operate.client.url='http://localhost:8081' \
    # -e camunda.operate.client.username='demo' \
    # -e camunda.operate.client.password='demo' \
    # -e operate.client.profile='simple' \
    # -e camunda.connector.operate.enabled='false' \
    # -e camunda.operate.client.keycloak-url='http://localhost:18080' \
    # -e camunda.operate.client.keycloak-realm='camunda-platform' \
    # -e camunda.operate.client.client-id='zeebe' \
    # -e camunda.operate.client.client-secret='zecret' \
    # -e CAMUNDA_TENANT_ID='<default>' \
    # -e CAMUNDA_SECURE_CONNECTION=false \

# docker run --rm --name=connectors -v "/home/andriy/projects/camunda-alfresco-connector-rohwerj/target/document-base64-api-0.1.0-SNAPSHOT.jar":/opt/app/connector.jar --env-file env.txt camunda/connectors-bundle:0.2.0

# java -cp "/opt/app/*:/opt/custom/*"

# java -jar ~/projects/Cognizant-Camunda-Connectors/azure-connectors/azure-servicebus-connector/target/azure-servicebus-connector-3.0.0-with-dependencies.jar