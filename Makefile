# Real-Time Streaming ETL Pipeline (Flink CDC + Elasticsearch)

BOLD := \033[1m
GREEN := \033[32m
YELLOW := \033[33m
BLUE := \033[34m
CYAN := \033[36m
RED := \033[31m
RESET := \033[0m

.PHONY: help setup down restart destroy logs ps mysql postgres jobmanager flink-sql urls

help:
	@echo "$(BOLD)$(CYAN)Flink CDC - Elasticsearch Pipeline$(RESET)"
	@echo ""
	@echo "$(BOLD)Docker Services$(RESET)"
	@echo "  $(YELLOW)setup$(RESET)        - Build & start all services"
	@echo "  $(YELLOW)down$(RESET)         - Stop all services"
	@echo "  $(YELLOW)restart$(RESET)      - Restart services"
	@echo "  $(YELLOW)destroy$(RESET)      - Remove containers + volumes"
	@echo "  $(YELLOW)logs$(RESET)         - Show logs"
	@echo "  $(YELLOW)ps$(RESET)           - List running containers"
	@echo ""
	@echo "$(BOLD)Access$(RESET)"
	@echo "  $(YELLOW)mysql$(RESET)        - Login to MySQL"
	@echo "  $(YELLOW)postgres$(RESET)     - Login to PostgreSQL"
	@echo "  $(YELLOW)jobmanager$(RESET)   - Open Flink JobManager shell"
	@echo ""
	@echo "$(BOLD)Pipeline$(RESET)"
	@echo "  $(YELLOW)flink-sql$(RESET)    - Open Flink SQL client"
	@echo ""
	@echo "  $(YELLOW)urls$(RESET)         - Show service URLs"
	@echo ""

setup:
	@echo "$(CYAN)Building images...$(RESET)"
	docker compose build --no-cache

	@echo "$(CYAN)Starting services...$(RESET)"
	docker compose up -d

	@echo "$(GREEN)System is running$(RESET)"

down:
	@echo "$(YELLOW)Stopping services...$(RESET)"
	docker compose down 

restart: down setup

destroy:
	@echo "$(RED)Removing containers + volumes...$(RESET)"
	docker compose down -v --remove-orphans

logs:
	docker compose logs -f

ps:
	docker compose ps

mysql:
	docker compose exec mysql mysql -uroot -p123456

postgres:
	docker-compose exec postgres psql -h localhost -U postgres

jobmanager:
	docker compose exec -it jobmanager bash

flink-sql:
	docker compose exec -it jobmanager ./bin/sql-client.sh

urls:
	@echo "$(BOLD)$(BLUE)Service URLs$(RESET)"
	@echo "Flink UI        http://localhost:8082"
	@echo "MySQL           localhost:3306"
	@echo "Postgres        localhost:5432"
	@echo "Elasticsearch   http://localhost:9200"
	@echo "Kibana          http://localhost:5601"