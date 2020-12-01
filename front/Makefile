.PHONY: build
build:
	docker-compose build

.PHONY: run
run:
	docker-compose up -d webpack
	docker-compose up app

.PHONY: down
down:
	docker-compose down

.PHONY: deploy
deploy:
	cd react-app && GENERATE_SOURCEMAP=false npm run build
	cd react-app && rm -fR build/js build/css
	cd react-app && aws s3 sync build/ s3://public-production-alice-catharsis --acl public-read
