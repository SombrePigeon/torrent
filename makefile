
update: docker-compose.yml
	$(MAKE) down
	docker-compose up -d --build
	touch update

down:
	docker-compose down
	rm -f update