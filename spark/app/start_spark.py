import sys, os
from pyspark.conf import SparkConf
from pyspark.sql import SparkSession, Catalog
from pyspark.sql import DataFrame, DataFrameStatFunctions, DataFrameNaFunctions
from pyspark.sql import functions as F
from pyspark.sql import types as T
from pyspark.sql.types import Row

from subprocess import check_output


if __name__ == "__main__":


    SPARK_DRIVER_HOST = check_output(["hostname", "-i"]).decode(encoding="utf-8").strip()

    movies_file = "./spark/resources/data/ratings_small.csv"

    spark_conf = SparkConf()

    spark_conf.setAll(
        [
            ("spark.master", "spark://spark:7077",), 
            ("spark.app.name", "myApp"),
            ("spark.submit.deployMode", "client"),
            ("spark.ui.showConsoleProgress", "true"),
            ("spark.eventLog.enabled", "false"),
            ("spark.logConf", "false"),
            ("spark.driver.bindAddress", "0.0.0.0", ),  
            ("spark.driver.host", SPARK_DRIVER_HOST, ), 
        ]
    )
    spark_sess = SparkSession.builder.config(conf=spark_conf).getOrCreate()
    spark_ctxt = spark_sess.sparkContext
    mov_df = spark_sess.read.format("csv") \
            .option("header", "true") \
            .option("inferSchema", "true") \
            .load(movies_file)
    
    count_rating_df = (mov_df
            .select("movieId", "rating")
            .groupBy("movieId")
            .agg(F.avg("rating").alias("avg_rating"))
            .orderBy("movieId", ascending=False))

    count_rating_df.show(n=40, truncate=False)

    spark_sess.stop()
    quit()

