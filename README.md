## Building a Real-Time Streaming ETL Pipeline with FlinkCDC and Elasticsearch


![workflow](https://github.com/zablon-oigo/flinkcdc-elasticsearch-streaming-etl/actions/workflows/docker-build.yaml/badge.svg)
![workflow](https://github.com/zablon-oigo/flinkcdc-elasticsearch-streaming-etl/actions/workflows/ci.yaml/badge.svg)
![Flink](https://img.shields.io/badge/Apache%20Flink-Stream%20Processing-E6526F?logo=apacheflink&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-CDC%20Source-4479A1?logo=mysql&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-CDC%20Source-336791?logo=postgresql&logoColor=white)
![Flink CDC](https://img.shields.io/badge/Flink%20CDC-Real%20Time%20ETL-orange)
![Docker](https://img.shields.io/badge/Docker-Containerized%20Environment-2496ED?logo=docker&logoColor=white)
![Elasticsearch](https://img.shields.io/badge/Elasticsearch-Search%20Engine-005571?logo=elasticsearch&logoColor=white)
![Kibana](https://img.shields.io/badge/Kibana-Data%20Visualization-005571?logo=kibana&logoColor=white)

This project demonstrates a real-time streaming ETL architecture that captures database changes from MySQL and PostgreSQL using CDC connectors, enriches the streams with Apache Flink SQL, and indexes the transformed data into Elasticsearch for low-latency search and analytics.

##### Architecture Diagram

<img width="1211" height="404" alt="image" src="https://github.com/user-attachments/assets/0549953c-b2e4-4f67-bdf2-52a4e2307a1c" />



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


#### Medium Article Link
[Building a Real-Time Streaming ETL Pipeline with FlinkCDC and Elasticsearch](https://medium.com/@zablon-oigo/building-a-real-time-streaming-etl-pipeline-with-flinkcdc-and-elasticsearch-8819aa6f302c)
