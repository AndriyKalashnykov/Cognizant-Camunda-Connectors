## SUMMARY


##### **List of connectors**
This project contains following set of Camunda outbound connectors which can be deployed as single application.


1) aws-lambda-connector
2) aws-s3-connector
3) aws-textract-connector
4) azure-blob-connector
5) azure-servicebus-connector(outbound)
6) azure-servicebus-connector(Inbound)
7) gcp-functions-connector
8) gcp-storage-connector
9) gcp-pub-connector
10) gcp-sub-connector	
11) kafka-connector
12) camelFTP-connector
13) drools-connector

##### **Note: please refer to Readme file for each of the above connector modules to gain detailed understanding of each connector setup.**

#### **SETTING UP THE CONNECTOR APPLICATION**
This project contains root pom.xml, which needs to be executed in order to build and include sub-modules
Upon execution of root pom.xml it compiles and packages individual sub-modules of the connector.
This project requires jdk21+.

In order to deploy this project in runtime environment follow below steps

1) Create a Zeebe client and configure it to connect to the desired SaaS/Self-Managed cluster
2) Add following dependency 
  ###### **groupId: com.cts.eas.ipm.connector**
  ###### **artifactId: cts-camunda-connectors**
  ###### **version: 3.0.0**
 
```bash
mvn clean dependency:copy-dependencies package install shade:shade -DskipTests
```

### Build and run azure-servicebus-connector

```bash
docker buildx build --load -t azure-servicebus-connector:latest -f Dockerfile .

docker run --rm --name=azure-servicebus-connector \
  -v $PWD/azure-connectors/azure-servicebus-connector/target/azure-servicebus-connector-3.0.0.jar:/opt/app/ \
  -e ZEEBE_ADDRESS='localhost:26500' \
  -e ZEEBE_CLIENT_ID='zeebe' \
  -e ZEEBE_CLIENT_SECRET='zecret'\
  -e CAMUNDA_OAUTH_URL='http://localhost:18080/auth/realms/camunda-platform/protocol/openid-connect/token' \
  -e CAMUNDA_TASKLIST_BASE_URL='http://localhost:8082' \
  -e CAMUNDA_OPERATE_BASE_URL='http://localhost:8081'  \
  -e CAMUNDA_OPTIMIZE_BASE_URL='http://localhost:8083' \
  -e CAMUNDA_MODELER_BASE_URL='http://localhost:8070/api' \
  -e CAMUNDA_TENANT_ID='<default>' \
  -e CAMUNDA_SECURE_CONNECTION=false \
  azure-servicebus-connector:latest

  docker logs --since=1h 'connectors' | tee connectors.log
  docker logs 'connectors' --follow
```