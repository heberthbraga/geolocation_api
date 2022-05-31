.PHONY: test

RAILS_ENV ?= test
COMPOSE_FILE := docker/compose/local.yml
DOCKER_COMPOSE_CMD := docker-compose -f ${COMPOSE_FILE}
EXEC_TEST_CMD := exec -e "RAILS_ENV=${RAILS_ENV}" api

drop-volumes:
	${DOCKER_COMPOSE_CMD} down --volumes

build-local:
	${DOCKER_COMPOSE_CMD} up -d --build

stop-local:
	${DOCKER_COMPOSE_CMD} stop

start-local:
	${DOCKER_COMPOSE_CMD} start -d

restart-local:
	${DOCKER_COMPOSE_CMD} restart

test-prepare:
	${DOCKER_COMPOSE_CMD} ${EXEC_TEST_CMD} bin/rails db:create db:migrate

rspec:
	${DOCKER_COMPOSE_CMD} ${EXEC_TEST_CMD} bundle exec rspec

cucumber:
	${DOCKER_COMPOSE_CMD} ${EXEC_TEST_CMD} bundle exec cucumber