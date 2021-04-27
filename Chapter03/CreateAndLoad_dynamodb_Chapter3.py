import boto3
import csv
import json

region='[YOUR-REDSHIFT-CLUSTER-REGION]'
s3_client = boto3.client('s3')
tableName = 'part'
dynamodb = boto3.resource('dynamodb',region)
table = dynamodb.create_table(
    TableName=tableName,
    KeySchema=[
        {
            'AttributeName': 'p_partkey',
            'KeyType': 'HASH'  #Partition key
        }
      ],
    AttributeDefinitions=[
        {
            'AttributeName': 'p_partkey',
            'AttributeType': 'N'
         }
    ],
    ProvisionedThroughput={
        'ReadCapacityUnits': 50,
        'WriteCapacityUnits': 50
        }
    )


table.meta.client.get_waiter('table_exists').wait(TableName=tableName)

partfile= s3_client.get_object(Bucket='[MYS3BUCKET]', Key='[PREFIX]/dynamodb-data/part.tbl')
recList = partfile['Body'].read().decode("utf-8").split('\n')
 
line_count = 0

for inpart_data in recList:
        line_count = line_count + 1
        if line_count % 1000 == 0:
            print(line_count)

        try:
            with table.batch_writer() as batch:
                part_data = inpart_data.split("|")
                batch.put_item(
                    Item = {
                        "p_partkey" : int(part_data[0]),
                        "p_name" : str(part_data[1]),
                        "p_mfgr" : str(part_data[2]),
                        "p_brand" : str(part_data[3]),
                        "p_type" : str(part_data[4]),
                        "p_size" : int(part_data[5]),
                        "p_container" : str(part_data[6]),
                        "p_retailprice" : str(part_data[7]),
                        "p_comment" : str(part_data[8])
                    }
                )

        except Exception as e:
            print(e)
           
