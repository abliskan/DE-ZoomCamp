FROM ubuntu:20.04

# Install Spark and PySpark
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV SPARK_VERSION=3.5.0
ENV HADOOP_VERSION=3
ENV SPARK_HOME=/opt/spark
ENV PATH=$SPARK_HOME/bin:$PATH
ENV JAVA_VERSION=11

# Pre-select the time zone
RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-pandas \
    "openjdk-${JAVA_VERSION}-jre-headless" \
    ca-certificates-java \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    tar -xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark && \
    rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    pip3 install pyspark==${SPARK_VERSION}

# Set up a non-root user
ARG USERNAME=sparkuser
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m -s /bin/bash $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Set ownership for Spark directories
RUN chown -R $USER_UID:$USER_GID ${SPARK_HOME}

# Create directories for logs and event logs
RUN mkdir -p ${SPARK_HOME}/logs \
    && mkdir -p ${SPARK_HOME}/event_logs \
    && chown -R $USER_UID:$USER_GID ${SPARK_HOME}/event_logs \
    && chown -R $USER_UID:$USER_GID ${SPARK_HOME}/logs

# Set up Spark configuration for logging and history server
RUN echo "spark.eventLog.enabled true" >> $SPARK_HOME/conf/spark-defaults.conf \
    && echo "spark.eventLog.dir file://${SPARK_HOME}/event_logs" >> $SPARK_HOME/conf/spark-defaults.conf \
    && echo "spark.history.fs.logDirectory file://${SPARK_HOME}/event_logs" >> $SPARK_HOME/conf/spark-defaults.conf

# Install Python packages for Jupyter and PySpark
RUN pip install --no-cache-dir jupyter findspark

# Copy the start-spark.sh script
COPY start-spark.sh /opt/start-spark.sh

# Make start-spark.sh executable
RUN chmod +x /opt/start-spark.sh

# Switch to non-root user
USER $USERNAME

# Set workdir and create application directories
RUN mkdir -p /home/$USERNAME/app

WORKDIR /home/$USERNAME/app

# Expose for Jupyter and Spark UI
EXPOSE 7077
EXPOSE 8080
EXPOSE 8081
EXPOSE 8088

# Start Spark
CMD ["/bin/bash", "/opt/start-spark.sh"]