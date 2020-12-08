import sys
import boto3
import json
import datetime

def lambda_handler(event, context):
    print(event)
    # initialize redshift-data client in boto3
    client = boto3.client("redshift-data")

    # input parameters passed from the caller event
    # cluster identifier for the Amazon Redshift cluster
    redshift_cluster_id = event['input'].get('redshift_cluster_id')
    # database name for the Amazon Redshift cluster
    redshift_database = event['input'].get('redshift_database')
    # database user in the Amazon Redshift cluster with access to execute relevant SQL queries
    redshift_user = event['input'].get('redshift_user')
    # sql command to be submitted
    sql_text = event['input'].get('sql_text')

    try:
        # execute the input SQL statement in the specified Amazon Redshift cluster
        res = client.execute_statement(Database=redshift_database, DbUser=redshift_user, Sql=sql_text,ClusterIdentifier=redshift_cluster_id, WithEvent=True)
        print(res)
        # return the event input along with the submit query_id
        event['query_id'] = res["Id"]
        return event
    except Exception as e:
        raise Exception(message)
