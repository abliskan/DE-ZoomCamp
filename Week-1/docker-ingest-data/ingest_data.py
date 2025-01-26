import os
import pandas as pd
import argparse

from sqlalchemy import create_engine
from time import time

def main(params):
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table_name = params.table_name
    url = params.url
    csv_name = 'output.csv'
    
    os.system (f"wget {url} - O {csv_name}")
    
    connection_str = f"postgresql://{user}:{password}@{host}:{port}/{db}"
    engine = create_engine(connection_str)
    
    try:
        with engine.connect() as connection_str:
            print('Successfully connected to the PostgreSQL database')
    except Exception as ex:
        print(f'Sorry failed to connect: {ex}')
    
    df_iter = pd.read_csv(csv_name, iterator=True, chunksize=100000)
    
    df = next(df_iter)
    
    df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
    df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)
    
    df.to_sql(name=table_name, con=engine, if_exists='append')
    
    while True:
        t_start = time()
        df = next(df_iter)
        df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
        df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)
        df.to_sql(name='yellow_taxi_data', con=engine, if_exists='replace')
        t_end = time()
        print("inserted another chunk data...., took %.3f" % (t_end - t_start))
    
if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Ingest CSV data to PostgreSQL!")
    
    parser.add_argument("user", help="username for postgres")
    parser.add_argument("password", help="password for postgres")
    parser.add_argument("host", help="host for postgres")
    parser.add_argument("port", help="port for postgres")
    parser.add_argument("db", help="db for postgres")
    parser.add_argument("table_name", help="table_name of the table where we will write the result to")
    parser.add_argument("url", help="url of the csv file")
    
    args = parser.parse_args()
    
    main(args)