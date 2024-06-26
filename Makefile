init:
	@cp .env.example .env
	@echo "Is this a production environment? [y/N]" && read ans && if [ "$$ans" = "y" ]; then ln -s docker-compose.prod.yml docker-compose.yml; else ln -s docker-compose.local.yml docker-compose.yml; fi

up:
	@docker compose up -d
start: up

down:
	@docker compose down --remove-orphans
stop: down

restart: down up

logs:
	@docker compose logs
tail:
	@docker compose logs -f

ps:
	@docker compose ps

clear:
	@docker compose down --remove-orphans --volumes
	@rm docker-compose.yml
	@rm .env

login-odoo:
	@docker compose exec --user odoo web bash

login-odoo-root:
	@docker compose exec --user root web bash

login-db:
	@docker compose exec --user postgres postgres bash

login-db-client:
	@echo "What database do you want to use? [odoo]" && read ans && if [ -z "$$ans" ]; then DB=odoo; else DB=$$ans; fi; docker compose exec --user postgres postgres psql --username=odoo --dbname=$$DB

regenerate-assets:
	@echo "What database do you want to use? [odoo]" && read ans && if [ -z "$$ans" ]; then DB=odoo; else DB=$$ans; fi; docker compose exec --user postgres postgres psql --username=odoo --dbname=$$DB -c "delete from ir_attachment where res_model='ir.ui.view' and name like '%assets_%';"