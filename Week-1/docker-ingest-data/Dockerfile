FROM python:3.12.8

RUN apt-get install wget
RUN pip install pandas sqlalchemy psycopg2

WORKDIR /app
COPY test1.py test1.py

ENTRYPOINT [ "python". "test1.py" ]