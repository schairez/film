help:
	@echo "up         - builds and/or runs the Docker images from compose file"
	@echo "db-shell   - Run the psql container shell" 
	@echo "jupyter    - Run the jupyter pynb instance " 


build-or-run:
	docker-compose -f docker-compose.yml up -d 

up: 
	docker-compose -f docker-compose.yml up -d 

down:
	docker-compose -f docker-compose.yml down

stop:
	docker-compose -f docker-compose.yml stop 

test-avg-rating-py-file: 
	docker-compose exec work-env python spark/app/start_spark.py
test-py-file:
	docker-compose exec work-env python ./sql.py

spark-shell:
	docker-compose exec work-env spark-shell 

spark-submit:
	docker exec film_spark_1 spark-submit --master spark://spark:7077 spark/app/start_spark.py 

jupyter:
	docker-compose start jupyter-spark 


jupyter_token:
	@docker logs films-jupyter-pyspark 2>&1 | grep '\?token\=' -m 1 | cut -d '=' -f2


db-shell:
	docker exec -it -u postgres films-db-dev psql

# docker container stop $(docker container ls -aq)

# read more here 
# https://medium.com/freestoneinfotech/simplifying-docker-compose-operations-using-makefile-26d451456d63

# could be issue with swap file? 
