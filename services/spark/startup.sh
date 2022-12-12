#!/bin/bash

##### Spark Cluster (Master/Worker) Startup Script #####
mkdir -p $SPARK_TMP_CODE_DIR $SPARK_TMP_RESULT_DIR

. "$SPARK_HOME/bin/load-spark-env.sh"

# Create logging files
mkdir -p $SPARK_LOG_DIR && \
    touch $SPARK_MASTER_LOG && \
    touch $SPARK_WORKER_LOG && \
    ln -sf /dev/stdout $SPARK_MASTER_LOG && \
    ln -sf /dev/stdout $SPARK_WORKER_LOG

# Run Spark
## Run as MASTER
if [ "$SPARK_WORKLOAD" == "master" ]; then
    export SPARK_MASTER_HOST=`hostname`
    cd $SPARK_HOME/bin && \
        ./spark-class org.apache.spark.deploy.master.Master \
            --ip $SPARK_MASTER_HOST \
            --port $SPARK_MASTER_PORT \
            --webui-port $SPARK_MASTER_WEBUI_PORT \
        >> $SPARK_MASTER_LOG

## Run as WORKER
elif [ "$SPARK_WORKLOAD" == "worker" ]; then
    cd $SPARK_HOME/bin && \
        ./spark-class org.apache.spark.deploy.worker.Worker \
        --webui-port $SPARK_WORKER_WEBUI_PORT "spark://$SPARK_MASTER_HOST" \
    >> $SPARK_WORKER_LOG

## Run as SUBMIT
elif [ "$SPARK_WORKLOAD" == "submit" ]; then
    echo "SPARK SUBMIT"
    echo "Submit job using `./send_job.sh --job JOB_NAME`"

## Other runtime
else
    echo "Undefined Workload Type $SPARK_WORKLOAD, must specify: master, worker, submit"
fi