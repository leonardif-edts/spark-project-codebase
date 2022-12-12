from pyspark.sql import SparkSession


def init_spark(name: str = "sample_runtime") -> SparkSession:
    spark = SparkSession.builder \
        .appName(name) \
        .getOrCreate()
    return spark