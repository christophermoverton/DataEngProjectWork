from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.python import PythonOperator
import pandas as pd


# Define default_args dictionary to specify default parameters for the DAG
default_args = {
    'owner': 'Christopher Overton',
    'depends_on_past': False,
    'start_date': datetime(2023, 11, 15),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Instantiate a DAG with the defined default_args
dag = DAG(
    'airflow_DAG_ETL_example',
    default_args=default_args,
    description='A simple ETL DAG',
    schedule_interval=timedelta(days=1),  # Run the DAG daily
)

# Define Python functions for each ETL task
def extract_task(**kwargs):
    # Your extract logic here
    filepath = '/home/christopher/airflow/dags/Global_Education.csv'
    print("Extracting data...")
    df = pd.read_csv(filepath)

    # Push the DataFrame to XCom for communication with downstream tasks
    kwargs['ti'].xcom_push(key='extracted_data', value=df)
    return None
    return None

def transform_task(**kwargs):
    # Your transform logic here
    print("Transforming data...")
    # Retrieve the DataFrame from XCom pushed by the extract_task
    ti = kwargs['ti']
    source_data = ti.xcom_pull(task_ids='extract_task', key='extracted_data')

    # Your transform logic here
    transformed_data = source_data.copy()
    transformed_data['OOSR_Pre0Primary_Age_Male_2'] = transformed_data['OOSR_Pre0Primary_Age_Male'] * 2

    # Push the transformed DataFrame to XCom for communication with downstream tasks
    kwargs['ti'].xcom_push(key='transformed_data', value=transformed_data)    
    return None

def load_task(**kwargs):
    # Your load logic here
    print("Loading data...")
    ti = kwargs['ti']
    transformed_data = ti.xcom_pull(task_ids='transform_task', key='transformed_data')

    # Your load logic here
    transformed_data.to_csv('/home/christopher/airflow/dags/output_data.csv', index=False)
    return None

# Define the tasks using PythonOperator
extract = PythonOperator(
    task_id='extract_task',
    python_callable=extract_task,
    provide_context=True,
    dag=dag,
)

transform = PythonOperator(
    task_id='transform_task',
    python_callable=transform_task,
    provide_context=True,
    dag=dag,
)

load = PythonOperator(
    task_id='load_task',
    python_callable=load_task,
    provide_context=True,
    dag=dag,
)

# Define a dummy task to indicate the end of the workflow

# Set the task dependencies
extract >> transform >> load 

# Optionally, you can define additional dependencies or tasks here

# Set the order of task execution using set_downstream and set_upstream methods
# extract.set_downstream(transform)
# transform.set_downstream(load)
# load.set_downstream(end_task)

