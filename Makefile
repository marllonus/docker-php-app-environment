up-build:
	USER_ID_VALUE=$$(id -u) GROUP_ID_VALUE=$$(id -g) docker-compose up -d --build

up:
	docker-compose up -d
