FROM bitnami/spark:3.2.3

USER root
RUN apt-get update && \
    apt-get install zip -y

USER 1001

WORKDIR /opt/bitnami/spark/work
COPY startup.sh cluster/

CMD ["/bin/bash", "cluster/startup.sh"]