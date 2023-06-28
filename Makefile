.PHONY: test

RAILS_ENV ?= test
COMPOSE_FILE := docker/compose/local.yml
DOCKER_COMPOSE_CMD := docker-compose -f ${COMPOSE_FILE}
EXEC_TEST_CMD := exec -e "RAILS_ENV=${RAILS_ENV}" api
ROOT_NAME := geolocation_app

drop-volumes:
	${DOCKER_COMPOSE_CMD} down --volumes

build-local:
	${DOCKER_COMPOSE_CMD} -p ${ROOT_NAME} up -d --build

up:
	${DOCKER_COMPOSE_CMD} -p ${ROOT_NAME} up -d

stop-local:
	${DOCKER_COMPOSE_CMD} -p ${ROOT_NAME} stop

start-local:
	${DOCKER_COMPOSE_CMD} -p ${ROOT_NAME} start

restart-local:
	${DOCKER_COMPOSE_CMD} -p ${ROOT_NAME} restart

test-prepare:
	${DOCKER_COMPOSE_CMD} -p ${ROOT_NAME} ${EXEC_TEST_CMD} bin/rails db:create db:migrate

rspec:
	${DOCKER_COMPOSE_CMD} -p ${ROOT_NAME} ${EXEC_TEST_CMD} bundle exec rspec

cucumber:
	${DOCKER_COMPOSE_CMD} -p ${ROOT_NAME} ${EXEC_TEST_CMD} bundle exec cucumber
