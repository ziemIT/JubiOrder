#TODO: add boto3 types
#TODO: to be removed
import json
from typing import Any, Dict, List


class DynamoDbTable:
    def __init__(self, ddb_client: Any, table_name: str) -> None:
        self._ddb_client = ddb_client
        self.table = table_name

    @property
    def table(self) -> str:
        return self._table

    @table.setter
    def table(self, table_name: str) -> None:
        if not table_name:
            raise ValueError("table_name cannot be None or empty")
        self._table = self._ddb_client.Table(table_name)

    #TODO: get_items with a integer limit or 0 if no limit
    def get_all_items(self) -> Dict[str, Any]:
        """
        - Uses boto3 dynamodb's Table.scan() method to fetch data.
        - No pagination!
        - Returns all items from DynamoDB table as JSON.
        """
        try:
            response = self._table.scan()
            data = response.get('Items', [])
            # This handles pagination
            while 'LastEvaluatedKey' in response:
                response = self._table.scan(
                    ExclusiveStartKey=response['LastEvaluatedKey']
                )
                data.extend(response.get('Items', []))
            output = {
                'statusCode': 200,
                'body': json.dumps(data),
                'headers': {'Content-Type': 'application/json'}
            }
        except Exception as e:
            print(f"Error : {str(e)}")
            output = {
                'statusCode': 500,
                'body': json.dumps({'error': str(e)})
            }
        return output

    def put_items(self, items: List[Dict[str, Any]], limit: int = 5) -> Dict[str, Any]:
        """
        TBA
        """
        output = []
        num_items = len(items)
        if num_items > limit:
            raise ValueError(f"Too many items. Limit is {limit}")
        with self.table.batch_writer() as batch:
            for i in range(num_items):
                try:
                    result = batch.put_item(Item=items[i])
                except Exception as e:
                    result = {'error': str(e)}
                output.append(result)
        response = {
            'statusCode': 200,
            'body': json.dumps({'output': output}),
            'headers': {'Content-Type': 'application/json'}
        }
        return response
