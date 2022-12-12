import os

from pyspark.sql import SparkSession
from pyspark.sql.dataframe import DataFrame
from pyspark.sql.functions import lit, col
from pyspark.sql.types import ArrayType, StructType


# TEST mode functions
def export_data_to_local(df: DataFrame, result_dir: str) -> DataFrame:
    df.write \
        .format("csv") \
        .options(header = True, delimiter = ";") \
        .mode("overwrite") \
        .save(result_dir)

def flatten_data(df: DataFrame) -> DataFrame:
    flt_df = df.select(*gen_flatten_schema(df.schema))
    return flt_df

def gen_flatten_schema(schema: StructType, prefix=None) -> list:
    fields = []
    for field in schema.fields:
        name = f"{prefix}.{field.name}" if (prefix) else field.name
        dtype = field.dataType

        if isinstance(dtype, ArrayType):
            dtype = dtype.elementType
        
        if isinstance(dtype, StructType):
            fields += gen_flatten_schema(dtype, prefix=name)
        else:
            fields.append(col(name).alias(name.replace(".", "_")))
    return fields

def get_sample_data(spark: SparkSession, filename: str) -> DataFrame:
    sample_datapath = os.path.join("project", "sample", filename)
    df = spark.read. \
        format("json"). \
        load(sample_datapath)
    return df

def process_data(df: DataFrame) -> DataFrame:
    prc_df = df.select(
        col("comments_author")[0].alias("author"),
        col("comments_comment")[0].alias("comment"),
    ).withColumn("source", lit("Instagram")
    ).na.drop("any")
    return prc_df