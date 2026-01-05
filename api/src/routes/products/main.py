#TODO: add boto3 types

import json
import boto3
import os

#TODO: change to use src.helpers.dynamodb
# needs terraform adjustment first
from dynamodb import DynamoDbTable

TABLE_NAME = os.environ.get('TABLE_NAME', None)

dynamodb = boto3.resource('dynamodb')
table = DynamoDbTable(dynamodb, TABLE_NAME)


def lambda_handler(event, context):
    #TODO: Please refactor this...
    if event.get("httpMethod", "").lower() == "get" \
    or event.get("http", {}).get("method", "").lower() == "get":
        response = table.get_all_items()
    else:
        response = {
                'statusCode': 405,
                'body': json.dumps({'error': "Method not allowed"})
            }

    return response
