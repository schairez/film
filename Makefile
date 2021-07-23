help:
	@echo "build - The Docker image omahoco/spark-postgres"
	@echo "postgres - Run a Postres container (exposes port 5432)"


build:
	docker-compose -f docker-compose.yml build 

up: 
	docker-compose -f docker-compose.yml up -d 


jupyter_token:
	@docker logs jupyter-pyspark 2>&1 | grep '\?token\=' -m 1 | cut -d '=' -f2


db-shell:
	docker-compose -f docker-compose.yml exec -it postgres bash \
		psql -U postgres 


# read more here 
# https://medium.com/freestoneinfotech/simplifying-docker-compose-operations-using-makefile-26d451456d63

