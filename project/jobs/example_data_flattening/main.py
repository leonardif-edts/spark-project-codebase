import argparse
import os

from jobs.example_data_flattening.functions import (
    export_data_to_local,
    flatten_data,
    get_sample_data,
    process_data
)
from shared import initiation

def get_args() -> dict:
    """
    Arguments Getter

    Get arguments from runtime.
    Update this function to modify which argument can be passed from command line to runtime.
    To know more, see https://docs.python.org/3/library/argparse.html
    """
    parser = argparse.ArgumentParser()
    parser.add_argument("job_name", action="store", metavar="job_name", help="Spark Job Name")
    parser.add_argument("--name", action="store", dest="name", metavar="name", help="Set name for Spark session")
    parser.add_argument("--test", action="store_true", dest="test", help="Set runtime into test mode")

    args = parser.parse_args()
    return {
        "name": args.name,
        "test": args.test
    }

def run(
    name: str,
    test: bool
):
    """
    Main Functionality

    Update this docstring with runtime explanation.

    params:
    - name: str. Set name for Spark session.
    - test: bool. Set runtime into test mode.
    """
    spark = initiation.init_spark(name)
    tmp_dir = os.environ.get("SPARK_TMP_RESULT_DIR")

    # Run in TEST mode
    if (test):
        raw_df = get_sample_data(spark, "example-data-flattening-result.json")
        flt_df = flatten_data(raw_df)
        prc_df = process_data(flt_df)

        abs_result_dir = os.path.join(tmp_dir, "example-data-flattening-result")
        export_data_to_local(prc_df, abs_result_dir)
    
    # Run in TEST mode
    else:
        pass