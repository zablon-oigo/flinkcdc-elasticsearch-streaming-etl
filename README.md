## Building a Real-Time Streaming ETL Pipeline with FlinkCDC and Elasticsearch


This project demonstrates a real-time streaming ETL architecture that captures database changes from MySQL and PostgreSQL using CDC connectors, enriches the streams with Apache Flink SQL, and indexes the transformed data into Elasticsearch for low-latency search and analytics.

##### Architecture Diagram

<img width="1179" height="388" alt="etl" src="https://github.com/user-attachments/assets/cdac40be-cf04-4fc3-bb9c-aff55c0a9d1e" />


Verify Indexed Document
```sh
curl localhost:9200/enriched_orders/_search?pretty
```

Search Orders By Shipment Destination

```sh
curl -X GET "localhost:9200/enriched_orders/_search?pretty" \
-H 'Content-Type: application/json' \
-d '{
  "query": {
    "match": {
      "destination": "Shanghai"
    }
  }
}'
```

Search Orders By Shipment Origin

```sh
curl -X GET "localhost:9200/enriched_orders/_search?pretty" \
-H 'Content-Type: application/json' \
-d '{
  "query": {
    "match": {
      "origin": "Hangzhou"
    }
  }
}'

```

Search Delivered Orders
```sh
curl -X GET "localhost:9200/enriched_orders/_search?pretty" \
-H 'Content-Type: application/json' \
-d '{
  "query": {
    "term": {
      "is_arrived": true
    }
  }
}'
```

Search By Product + Shipment

```sh
curl -X GET "localhost:9200/enriched_orders/_search?pretty" \
-H 'Content-Type: application/json' \
-d '{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "product_name": "hammer"
          }
        },
        {
          "match": {
            "destination": "Shanghai"
          }
        }
      ]
    }
  }
}'
```
