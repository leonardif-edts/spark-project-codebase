FROM bitnami/spark:3.2.3

USER root
RUN apt-get update && \
    apt-get install zip -y

USER 1001

ENV SPARK_HOME=/opt/bitnami/spark
ENV SPARK_TMP_DIR=$SPARK_HOME/work/tmp
ENV SPARK_TMP_CODE_DIR=$SPARK_TMP_DIR/code
ENV SPARK_TMP_RESULT_DIR=$SPARK_TMP_DIR/result

WORKDIR /opt/bitnami/spark/work
COPY startup.sh cluster/startup.sh

CMD ["/bin/bash", "cluster/startup.sh"]