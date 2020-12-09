from __future__ import print_function

import sys
import boto3
import json
import datetime

def lambda_handler(event, context):
    print(event)
    # initialize redshift-data client in boto3
    client = boto3.client("redshift-data")

    # query_id to input for action status_check
    query_id = event['query_id']
    
    # check the status of the execution for submitted query_id in the specified Amazon Redshift cluster
    try:
        # find the status of query_id for the submission made
        desc = client.describe_statement(Id=query_id)
        print(desc)
        # return the query_id status
        return desc["Status"]
    except Exception as e:
        raise Exception(message)

