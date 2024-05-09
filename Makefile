init:
	cp .env.example .env

up:
	docker compose up -d
start: up

down:
	docker compose down --remove-orphans
stop: down

restart: down up

logs:
	docker compose logs
tail:
	docker compose logs -f

ps:
	docker compose ps

clear:
	docker compose down --remove-orphans --volumes

login:
	docker compose exec odoo bash