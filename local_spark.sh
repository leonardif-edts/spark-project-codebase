# Spark - Local Script
# 
# Deployment and usage guide for Local Spark in Docker
# Run each command separately to see each stage of deployment/testing.

# Build Image
# pattern: docker build -t IMAGE_NAME DOCKERFILE_DIR
docker build -t spark-standalone:0.1 ./services/spark

# Run Container
# pattern: docker run --name CONTAINER_NAME -d IMAGE_NAME sleep infinity
docker run --name spark-standalone -v ${pwd}/project:/opt/bitnami/spark/work/project -d spark-standalone:0.1 sleep infinity

# Run Sample Job
# pattern: docker exec CONTAINER_NAME bash -c '${SPARK_HOME}/bin/pyspark project/runner.py JOB_NAME ARGS*'
docker exec spark-standalone bash -c '${SPARK_HOME}/bin/spark-submit project/runner.py example_data_flattening --test'

# Check Data Result
# pattern: docker exec CONTAINER_NAME bash -c 'ls tmp/result/JOB_NAME-result' 
docker exec spark-standalone bash -c 'ls tmp/result/example-data-flattening-result'

# Stop Container
# pattern: docker container stop CONTAINER_NAME
docker container stop spark-standalone

# Delete Container
# pattern: docker container rm CONTAINER_NAME
docker container rm spark-standalone

# Remove Image
# pattern: docker image rm IMAGE_NAME
docker image rm spark-standalone:0.1