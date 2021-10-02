ifeq ($(WEBSITES_ENV), prod)
 $(info prod $(WEBSITES_ENV) detected)
 COMPOSE_FILE=docker-compose.yml
else ifeq ($(WEBSITES_ENV), dev)
 $(info prod $(WEBSITES_ENV) detected)
 COMPOSE_FILE=docker-compose-dev.yml
else
 $(error : WEBSITES_ENV is not defined to "dev" or "prod";)
endif

update: $(COMPOSE_FILE) dockerfile
	$(MAKE) down
	docker-compose -f $(COMPOSE_FILE) up -d --build
	touch update

down:
	docker-compose -f $(COMPOSE_FILE) down
	rm -f update