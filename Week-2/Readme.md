# MODULE-2: WORFLOW ORCHESTRATION WITH KESTRA
## Introduction
Kestra is an open-source infinitely-scalable orchestration platform enabling all engineers to manage business-critical workflows declaratively in code. Declarative syntax in kestra workflow bringing Infrastructure as Code best practices to data, process, and microservice orchestration, we can build reliable workflows directly from the UI in just a few lines of YAML.

## Objective
- Get familiarize with kestra service and key concept of workflow
- Create YAML based configuration inside 'flow' to perform orchestration
- Build automation data ingestion and integration process for both PostgreSQL and GCS/Biquery
- Set up schedules for periodic workflow and running backfill data for historical periods
- Set up GCP credentials using namespace in the Kestra UI to store key-value pairs
- Integrate dbt for automate data modeling and data tranformation

## Dataset
- Yellow taxi data
- Green taxi data
- Misc (zone lookup file)

## Getting started
### Docker setup 
You can adjust Kestra's configuration using a file passed to the Docker container as a bind volume.
```
docker run --pull=always --rm -it -p 8080:8080 --user=root kestra/kestra:develop-full server local
```

### Docker-compose setup 
1) Get docker-compose from kestra doc
<-> Download the Docker Compose file using the following command on Linux and macOS
```
curl -o docker-compose.yml \
https://raw.githubusercontent.com/kestra-io/kestra/develop/docker-compose.yml
```
<-> or use the current docker-compose setup <br>
```
networks:
  local:

services:
  kestra-metadata:
    image: postgres:17-alpine
    container_name: kestra-metadata
    volumes:
      - vol-kestra-metadata:/var/lib/postgresql/data
    environment:
      POSTGRES_DB: kestra
      POSTGRES_USER: kestra
      POSTGRES_PASSWORD: k3str4
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -d $${POSTGRES_DB} -U $${POSTGRES_USER}"]
      interval: 30s
      retries: 10
    networks:
      - local

  kestra:
    image: kestra/kestra:latest
    container_name: kestra    
    pull_policy: always
    # Note that this setup with a root user is intended for development purpose.
    # Our base image runs without root, but the Docker Compose implementation needs root to access the Docker socket
    # To run Kestra in a rootless mode in production, see: https://kestra.io/docs/installation/podman-compose
    user: "root"
    command: server standalone
    volumes:
      - vol-kestra-data:/app/storage
      - /var/run/docker.sock:/var/run/docker.sock
      - /tmp/kestra-wd:/tmp/kestra-wd
    environment:
      KESTRA_CONFIGURATION: |
        datasources:
          postgres:
            url: jdbc:postgresql://kestra-metadata:5432/kestra
            driverClassName: org.postgresql.Driver
            username: kestra
            password: k3str4
        kestra:
          server:
            basicAuth:
              enabled: false
              username: "admin@kestra.io" # it must be a valid email address
              password: kestra
          repository:
            type: postgres
          storage:
            type: local
            local:
              basePath: "/app/storage"
          queue:
            type: postgres
          tasks:
            tmpDir:
              path: /tmp/kestra-wd/tmp
          url: http://localhost:8080/
    ports:
      - "8080:8080"
      - "8081:8081"
    networks:
      - local
    env_file: .env_encoded
    depends_on:
      kestra-metadata:
        condition: service_healthy

  postgres_zoomcamp:
    image: postgres:17-alpine
    container_name: postgres_zoomcamp
    environment:
      POSTGRES_USER: 'postgres'
      POSTGRES_PASSWORD: 'postgres-kestra'
      POSTGRES_DB: 'nyc_taxi'
    ports:
      - '6000:5432'
    volumes:
      - vol-pgdata:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres"]
      interval: 5s
      timeout: 5s
      retries: 5
    restart: on-failure
    networks:
      - local

volumes:
  vol-pgdata:
    name: vol-pgdata
  vol-kestra-metadata:
    name: vol-kestra-metadata
  vol-kestra-data:
    name: vol-kestra-data
```
<-> Use the following command to start the Kestra server<br>
```
docker-compose up -d
```
<-> Open the URL http://localhost:8080 in your browser to launch the UI. <br>
<-> Use the following command to stop the Kestra server
```
docker-compose down
```
(next)

### Ingest NYC Taxi data into PostgreSQL
(comming soon)

### Ingest NYC Taxi data into datalake(GCS) and data warehouse (Bigquery)
(comming soon)

### Integration with Dbt for data transform
(comming soon)

### Deploy kestra orchestration to the cloud
(comming soon)

## Homework 
See the [howework-wk2 folder](https://github.com/abliskan/DE-ZoomCamp/blob/main/Week-2/howework-wk2/Readme.md)
