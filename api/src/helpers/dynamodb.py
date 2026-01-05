#TODO: add boto3 types

import json
from typing import Any, Dict


class DynamoDbTable:
    def __init__(self, ddb_client: Any, table_name: str) -> None:
        self._ddb_client = ddb_client
        self._table = table_name

    @property
    def table(self) -> str:
        return self._table

    @table.setter
    def table(self, table_name: str) -> None:
        if not table_name:
            raise ValueError("table_name cannot be None or empty")
        self._table = self._ddb_client.Table(table_name)

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


    def put_item(self, item: Dict[str, Any]) -> Dict[str, Any]:
        raise NotImplementedError
        # item = {
        #     'product_Id': product_id,       # Partition Key
        #     'name': body['name'],           # String
        #     'description': body.get('description', ''), # String (pusty jeśli brak)
        #     'price': price,                 # Number (Decimal)
        #     'image_URL': body.get('image_URL') # String lub None (DynamoDB obsłuży null)
        # }

        # 4. Zapis do bazy (put_item nadpisuje item jeśli klucz już istnieje)
        # try:
        #     table.put_item(Item=item)
        #     # 5. Sukces - zwracamy ID utworzonego produktu
        #     output = {
        #         'statusCode': 201,
        #         'body': json.dumps(
        #             {
        #                 'message': 'Item added',
        #                 'product_Id': 'Id' # TODO: chanfge this
        #             }
        #         ),
        #         'headers': {'Content-Type': 'application/json'}
        #     }
        # except Exception as e:
        #     print(f"Error: {str(e)}")
        #     output = {
        #         'statusCode': 500,
        #         'body': json.dumps({'error': str(e)})
        #     }
        # return output
