import json
import os

import boto3


dynamodb = boto3.client("dynamodb")


def _cors_headers(event):
    allowed_origins = [origin.strip() for origin in os.environ["ALLOWED_ORIGINS"].split(",")]
    request_headers = event.get("headers") or {}
    request_origin = request_headers.get("origin") or request_headers.get("Origin")

    if "*" in allowed_origins:
        origin = "*"
    elif request_origin in allowed_origins:
        origin = request_origin
    else:
        origin = allowed_origins[0]

    return {
        "Access-Control-Allow-Origin": origin,
        "Content-Type": "application/json",
        "Cache-Control": "no-store",
    }


def handler(event, _context):
    response = dynamodb.update_item(
        TableName=os.environ["TABLE_NAME"],
        Key={
            "counter_id": {
                "S": os.environ["COUNTER_ID"],
            },
        },
        UpdateExpression="ADD visits :increment",
        ExpressionAttributeValues={
            ":increment": {
                "N": "1",
            },
        },
        ReturnValues="UPDATED_NEW",
    )

    count = int(response["Attributes"]["visits"]["N"])

    return {
        "statusCode": 200,
        "headers": _cors_headers(event),
        "body": json.dumps({"count": count}),
    }
