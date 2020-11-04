.PHONY: build
build:
	docker-compose build

.PHONY: run
run:
	-docker network create alice-catharsis-network
	docker-compose up

.PHONY: down
down:
	docker-compose down

.PHONY: console
console:
	docker-compose run --rm app rails console

.PHONY: reset-db
reset-db:
	docker-compose run --rm app bundle exec rake db:drop db:create
	@make migrate
	@make seed

.PHONY: routes
routes:
	docker-compose run --rm app bundle exec rails routes

.PHONY: migrate
migrate:
	docker-compose run --rm app bundle exec ridgepole --config ./config/database.yml -E development --file ./db/Schemafile --apply

.PHONY: seed
seed:
	docker-compose run --rm app bundle exec rails db:seed:replant

.PHONY: console
console:
	docker-compose run --rm app bundle exec rails console

.PHONY: lint
lint:
	docker-compose exec app rubocop --auto-correct

.PHONY: test
test:
	docker-compose run --rm app bundle exec rake db:drop db:create RAILS_ENV=test
	docker-compose run --rm app bundle exec ridgepole --config ./config/database.yml -E test --file ./db/Schemafile --apply
	docker-compose run --rm app bundle exec rspec spec
