ARG FLINK_VERSION=2.0

FROM apache/flink:${FLINK_VERSION}-java17

SHELL ["/bin/bash", "-c"]

USER flink

WORKDIR /opt/flink


# Download necessary CDC connectors and runtime modules
RUN wget -q --no-check-certificate -O /opt/flink/lib/flink-sql-connector-mysql-cdc-3.6.0-2.2.jar \
    https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-mysql-cdc/3.6.0-2.2/flink-sql-connector-mysql-cdc-3.6.0-2.2.jar || echo "SQL connector download skipped" && \
    wget -q --no-check-certificate -O /opt/flink/lib/flink-sql-connector-kafka.jar \
    https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-kafka/4.0.0-2.0/flink-sql-connector-kafka-4.0.0-2.0.jar || echo "Kafka SQL connector download skipped" && \
    wget -q --no-check-certificate -O /opt/flink/lib/flink-cdc-pipeline-connector-mysql-3.6.0-2.2.jar \
    https://repo1.maven.org/maven2/org/apache/flink/flink-cdc-pipeline-connector-mysql/3.6.0-2.2/flink-cdc-pipeline-connector-mysql-3.6.0-2.2.jar && \
    wget -q --no-check-certificate -O /opt/flink/lib/flink-cdc-pipeline-connector-kafka-3.6.0-2.2.jar \
    https://repo1.maven.org/maven2/org/apache/flink/flink-cdc-pipeline-connector-kafka/3.6.0-2.2/flink-cdc-pipeline-connector-kafka-3.6.0-2.2.jar && \
    wget -q --no-check-certificate -O /opt/flink/lib/flink-cdc-cli-3.6.0-2.2.jar \
    https://repo1.maven.org/maven2/org/apache/flink/flink-cdc-cli/3.6.0-2.2/flink-cdc-cli-3.6.0-2.2.jar && \
    wget -q --no-check-certificate -O /opt/flink/lib/snakeyaml-engine-2.7.jar \
    https://repo1.maven.org/maven2/org/snakeyaml/snakeyaml-engine/2.7/snakeyaml-engine-2.7.jar && \
    wget -q --no-check-certificate -O /opt/flink/lib/mysql-connector-j-8.3.0.jar \
    https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.3.0/mysql-connector-j-8.3.0.jar && \
    wget -q --no-check-certificate -O /opt/flink/lib/flink-sql-connector-postgres-cdc-3.6.0-2.2.jar \
    https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-postgres-cdc/3.6.0-2.2/flink-sql-connector-postgres-cdc-3.6.0-2.2.jar && \
    wget -q --no-check-certificate -O /opt/flink/lib/flink-sql-connector-elasticsearch7-4.0.0-2.0.jar \
    https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-elasticsearch7/4.0.0-2.0/flink-sql-connector-elasticsearch7-4.0.0-2.0.jar

