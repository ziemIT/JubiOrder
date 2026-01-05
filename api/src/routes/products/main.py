#TODO: add boto3 types

import json
import boto3
import os

#TODO: change to use src.helpers.dynamodb
# needs terraform adjustment first
from dynamodb import DynamoDbTable
from utils import get_http_method

TABLE_NAME = os.environ.get('TABLE_NAME', None)

dynamodb = boto3.resource('dynamodb')
table = DynamoDbTable(dynamodb, TABLE_NAME)


def lambda_handler(event, context):
    #TODO: Please refactor this...
    event_http_method = get_http_method(event).lower()
    if  event_http_method == "get":
        response = table.get_all_items()
    elif event_http_method == "post":
        items = event.get("data", {})
        response = table.put_items(items)
    else:
        response = {
                'statusCode': 405,
                'body': json.dumps({'error': "Method not allowed"})
            }

    return response
