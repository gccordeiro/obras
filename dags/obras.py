import pandas as pd
import yaml
import os
from airflow.decorators import dag, task
from airflow.utils.dates import days_ago
from airflow.providers.postgres.hooks.postgres import PostgresHook

default_args = {
    'owner': 'airflow',
}


@dag(default_args=default_args, schedule_interval="0 0 * * *", start_date=days_ago(2))
def obras_elt():

    @task()
    def extract_and_load():

        with open(os.path.join(os.environ['AIRFLOW_HOME'],
                               "dags", "config.yaml"), 'r') as file:
            config = yaml.load(stream=file, Loader=yaml.FullLoader)

        for url in config['urls'].values():
            df = pd.read_csv(url, sep=';')
            with PostgresHook().get_connection() as conn:
                df.to_sql('stage_obra', con=conn, if_exists='append')

    @task()
    def transform_dims():

        with open(os.path.join(os.environ['AIRFLOW_HOME'],
                               "dags", "dims.sql"), 'r') as file:
            sql = file

            with PostgresHook().get_connection() as conn:
                conn.execute(sql)

    @task()
    def transform_fact():

        with open(os.path.join(os.environ['AIRFLOW_HOME'],
                               "dags", "fact.sql"), 'r') as file:
            sql = file

            with PostgresHook().get_connection() as conn:
                conn.execute(sql)

    task_extract_and_load = extract_and_load()
    task_transform_dims = transform_dims()
    task_transform_fact = transform_fact()

    task_extract_and_load >> task_transform_dims >> task_transform_fact


obras_elt_dag = obras_elt()
