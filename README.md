### Cognizant Camunda Connectors

## Pre-requisites

* Linux
* JDK 21
* Docker

## TDLR: Run a custom connector with Self-Manages Camunda 8.7

### Copy templates to local [Camunda Desktop Modeler](https://camunda.com/download/modeler/)

```bash
cp ~/projects/Cognizant-Camunda-Connectors/azure-connectors/azure-servicebus-connector/element-template/*.json ~/.config/camunda-modeler/resources/element-templates/
```

### Deploy and run BPMN with [Camunda Desktop Modeler](https://camunda.com/download/modeler/)

- Start [Camunda Desktop Modeler](https://camunda.com/download/modeler/)
- Open file `c8-sdk-demo.bpmn`
- Deploy diagram to "Camunda 8 Self-Managed": use a`space ship` pictogram in status bar), set `Cluster endpoint` to `http://localhost:26500` and `Authentication` as `None`
- Start BPMN: `Start Current Diagram`- use an `arrow` pictogram in status bar

### Build and run azure-servicebus-connector

```bash
mvn clean package -DskipTests
docker buildx build --load -t azure-servicebus-connector:latest -f Dockerfile .
cd camunda-local && docker compose -f docker-compose-core.yaml up -d
cd camunda-local && docker compose -f docker-compose-core.yaml down

docker logs --since=1h 'connectors' | tee connectors.log
docker logs 'connectors' --follow

cp ./azure-connectors/azure-servicebus-connector/target/*.jar /home/andriy/projects/connector-template-inbound/target/
```

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
 

* [Operate](http://localhost:8081)
* [Tasklist](http://localhost:8082)
* [Web Modeler](http://localhost:8070)

### Running standalone container (never worked)

```bash
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
```  