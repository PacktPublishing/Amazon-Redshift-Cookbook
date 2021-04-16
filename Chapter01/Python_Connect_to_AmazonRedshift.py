import boto3
import json

redshift_cluster_id = "cookbook"
redshift_database = "dev"
aws_region_name = "us-west-2"
secret_arn="arn:aws:secretsmanager:us-west-2:123456789012:secret:aes128-1a2b3c"
def get_client(service, region="yourClusterRegion"):
    import botocore.session as bc
    session = bc.get_session()
    s = boto3.Session(botocore_session=session, region_name=region)
    return s.client(service)
rsd = get_client('redshift-data')
resp = rsd.execute_statement(
    SecretArn= secret_arn
    ClusterIdentifier=redshift_cluster_id,
    Database= redshift_database,
    Sql="SELECT sysdate;"
)
queryId = resp['Id']
print(f"asynchronous query execution: query id {queryId}")
stmt = rsd.describe_statement(Id=queryId)
desc = None
while True:
        desc = rsd.describe_statement(Id=queryId)        
        if desc["Status"] == "FINISHED":            
            break
            print(desc["ResultRows"])
if desc and desc["ResultRows"]  > 0:
   result = rsd.get_statement_result(Id=queryId)
   print("results JSON" + "\n")
   print(json.dumps(result, indent = 3))     
