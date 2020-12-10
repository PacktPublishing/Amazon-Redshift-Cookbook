from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.operators.postgres_operator import PostgresOperator
from airflow.hooks.postgres_hook import PostgresHook
from airflow.utils.dates import days_ago
from datetime import datetime, timedelta
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)



create_table_sql = '''DROP TABLE IF EXISTS PART_STG;
               CREATE TABLE part_stg 
               (
                 P_PARTKEY  BIGINT NOT NULL,
                 P_NAME          VARCHAR(55),
                 P_MFGR          VARCHAR(25),
                 P_BRAND         VARCHAR(10),
                 P_TYPE          VARCHAR(25),
                 P_SIZE          INTEGER,
                 P_CONTAINER     VARCHAR(10),
                 P_RETAILPRICE   DECIMAL(18,4),
                 P_COMMENT       VARCHAR(23)
                );'''
				
load_sql = '''copy public.part_stg from 's3://<your-bucket>/ssb/part/' iam_role '<your-iam-role' gzip csv region 'us-east-1'; '''
     
def check_record_count(*args, **kwargs):
    table = kwargs["params"]["table"]
    redshift_hook = PostgresHook("redshift_conn")
    records = redshift_hook.get_records(f"SELECT COUNT(*) FROM {table}")
    if len(records) < 1 or len(records[0]) < 1:
        raise ValueError(f"Data quality check failed. {table} returned no results")
    num_records = records[0][0]
    if num_records < 1:
        raise ValueError(f"Data quality check failed. {table} contained 0 rows")
    logging.info(f"Data quality on table {table} check passed with {records[0][0]} records")

args = {"owner": "airflow", "start_date": days_ago(2)}
dag = DAG(dag_id="parts-redshift-datapipline-dag", 
	        default_args=args, 
			schedule_interval="@daily",
            dagrun_timeout=timedelta(minutes=10),
            max_active_runs=1
           )			
create_table = PostgresOperator(task_id="redshift_parts_stg_create",sql=create_table_sql,postgres_conn_id="redshift_conn", 	dag=dag)
load_data = PostgresOperator(task_id="redshift_parts_stg_load",sql=load_sql,postgres_conn_id="redshift_conn", dag=dag )
#get_count = PostgresOperator(task_id="redshift_parts_stg_recordcount",postgres_conn_id="redshift_conn", sql='select count(*) from public.part_stg', dag=dag)
get_count = PythonOperator(
    task_id='redshift_parts_stg_recordcount',
    dag=dag,
    python_callable=check_record_count,
    provide_context=True,
    params={
        'table': 'public.part_stg',
    }
)
create_table>> load_data >> get_count