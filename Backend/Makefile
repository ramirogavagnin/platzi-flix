.PHONY: start stop restart build logs clean help migrate seed seed-only

# Comando principal para iniciar el entorno de desarrollo
start:
	docker-compose up -d

# Detener los contenedores
stop:
	docker-compose down

# Reiniciar los contenedores
restart:
	docker-compose restart

# Construir las imágenes
build:
	docker-compose build

# Ver los logs de los contenedores
logs:
	docker-compose logs -f

# Limpiar contenedores, volúmenes e imágenes
clean:
	docker-compose down -v --rmi all --remove-orphans

# Ejecutar migraciones de base de datos
migrate:
	docker-compose exec api uv run alembic upgrade head

# Ejecutar seeds de base de datos
seed:
	docker-compose exec api uv run python scripts/run_seeds.py

# Ejecutar solo seeds (con script)
seed-only:
	docker-compose exec api ./scripts/seed_only.sh

# Mostrar ayuda
help:
	@echo "Comandos disponibles:"
	@echo "  make start    - Iniciar el entorno de desarrollo"
	@echo "  make stop     - Detener los contenedores"
	@echo "  make restart  - Reiniciar los contenedores"
	@echo "  make build    - Construir las imágenes"
	@echo "  make logs     - Ver logs de los contenedores"
	@echo "  make migrate  - Ejecutar migraciones de base de datos"
	@echo "  make seed     - Ejecutar seeds de base de datos"
	@echo "  make seed-only - Ejecutar solo seeds (script)"
	@echo "  make clean    - Limpiar contenedores y volúmenes"
	@echo "  make help     - Mostrar esta ayuda"

# Comando por defecto
.DEFAULT_GOAL := help