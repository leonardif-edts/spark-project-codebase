##### VARIABLES #####
CODE_DIR=${SPARK_HOME}/work/project/*
CODE_ZIP=${SPARK_TMP_CODE_DIR}/project.zip

SPARK_ARGS=( "$@" )
JOB_NAME=${SPARK_ARGS[0]}
CODE_ZIP=${SPARK_TMP_CODE_DIR}/${JOB_NAME}.zip


##### MAIN #####
# Zip codes to be sent
zip ${CODE_ZIP} ${CODE_DIR} -x '*__pycache__*'

# Submit via Spark-Submit
${SPARK_HOME}/bin/spark-submit \
    --master spark://$SPARK_MASTER_HOST \
    --deploy-mode client \
    --driver-memory 1g \
    --executor-memory 1g \
    --executor-cores 1 \
    --py-files ${CODE_ZIP} \
    ${SPARK_HOME}/work/project/runner.py ${SPARK_ARGS[*]}

# Clean Runtime
rm -rf ${SPARK_TMP_CODE_DIR}/*