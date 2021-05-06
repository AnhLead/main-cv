import os
import boto3
import decimal
import json

dynamodb = boto3.resource('dynamodb')
c = dynamodb.Table('website-counter-Terraform')

# Helper class to convert a DynamoDB item to JSON.
class DecimalEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, decimal.Decimal):
            if o % 1 > 0:
                return float(o)
            else:
                return int(o)
        return super(DecimalEncoder, self).default(o)

# Variables
website = 'anhtran.co.uk'
counter = 0  

update = c.update_item(
    Key={
        'Website': website,
        'Counter': counter
    },
    UpdateExpression = 'SET UpdatedCounter = UpdatedCounter + :val',
    ExpressionAttributeValues={
        ':val' : decimal.Decimal(1) 
    },
    ReturnValues = "UPDATED_NEW"
)
