#!/bin/bash

SPARK_MODE=${SPARK_MODE:-master}

if [ "$SPARK_MODE" = "master" ]; then
  /opt/spark/sbin/start-master.sh -h 0.0.0.0
elif [ "$SPARK_MODE" = "worker" ]; then
  /opt/spark/sbin/start-worker.sh spark://${SPARK_MASTER_URL:-spark-master}:7077
else
  echo "Invalid SPARK_MODE: $SPARK_MODE"
  exit 1
fi

tail -f /dev/null # Keep the container running