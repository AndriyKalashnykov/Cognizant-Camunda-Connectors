### Cognizant Camunda Connectors

## Pre-requisites

* Linux
* sdkman[https://sdkman.io/]
  - Install [sdkman](https://sdkman.io/install)
    ```bash
    curl -s "https://get.sdkman.io" | bash
    ```
* JDK 21
  - Install and use JDK
    ```bash
    sdk install java 21.0.7-tem
    sdk use java 21.0.7-tem
    ```
* [Apache Maven](https://maven.apache.org/install.html)
  - Install Apache Maven 
    ```bash
    sdk install maven 3.9.9
    sdk use maven 3.9.9
    ```    
* [Docker](https://docs.docker.com/engine/install/)
* [Camunda Desktop Modeler](https://camunda.com/download/modeler/)

## TDLR: Run a custom connector [azure-servicebus-connector](/azure-connectors/azure-servicebus-connector) with Self-Managed Camunda 8.7

### Make Connector's templates available to a localy installed [Camunda Desktop Modeler](https://camunda.com/download/modeler/)

```bash
cp ~/projects/Cognizant-Camunda-Connectors/azure-connectors/azure-servicebus-connector/element-template/*.json ~/.config/camunda-modeler/resources/element-templates/
```

### Deploy and run BPMN with [Camunda Desktop Modeler](https://camunda.com/download/modeler/)

- Start local [Camunda Desktop Modeler](https://camunda.com/download/modeler/)
- Open file `c8-sdk-demo.bpmn`
- Deploy diagram to "Camunda 8 Self-Managed": use a`space ship` pictogram in status bar), set `Cluster endpoint` to `http://localhost:26500` and `Authentication` as `None`
- Start BPMN: `Start Current Diagram`- use an `arrow` pictogram in status bar

## Build Connector JAR

```bash
make build
```

## Build Connector Docker Image 

```bash
make image-build
```

## Start Docker Compose (uses previously build Connector Docker image)

```bash
make cmpose-up
```

## Observe container `connectors` logs

Tail logs
```bash
make container-logs
```

or save as a file

```bash
docker logs --since=1h 'connectors' | tee connectors.log
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
