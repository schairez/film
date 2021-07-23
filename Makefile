help:
	@echo "build      - builds the Docker images from compose file"
	@echo "db-shell   - Run a psql container" 


build-and-run:
	docker-compose -f docker-compose.yml up -d 

up: 
	docker-compose -f docker-compose.yml up -d 

down:
	docker-compose -f docker-compose.yml down

stop:
	docker-compose -f docker-compose.yml stop 

jupyter:
	docker-compose -f docker-compose.yml run -it \
		-v /tmp:/data \
		--name jupyter_pyspark \
		--restart always \
		-d jupyter/pyspark-notebook


jupyter_token:
	@docker logs films-jupyter-pyspark 2>&1 | grep '\?token\=' -m 1 | cut -d '=' -f2


db-shell:
	docker exec -it -u postgres films-db-dev psql


# read more here 
# https://medium.com/freestoneinfotech/simplifying-docker-compose-operations-using-makefile-26d451456d63

