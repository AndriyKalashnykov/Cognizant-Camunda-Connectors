```bash
docker run --rm --name=azure-servicebus-connector \
    -v $PWD/azure-servicebus-connector/target/azure-servicebus-connector-3.0.0.jar:/opt/app/connector.jar \
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
```
