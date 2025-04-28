cd ~/projects/Cognizant-Camunda-Connectors
mvn clean package install -DskipTests
cd ~/projects/Cognizant-Camunda-Connectors/azure-connectors/azure-servicebus-connector
mvn clean dependency:copy-dependencies package install shade:shade -DskipTests
cd ~/projects/Cognizant-Camunda-Connectors