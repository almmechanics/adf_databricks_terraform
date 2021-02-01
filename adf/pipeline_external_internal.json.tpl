[
    {
        "name": "Copy From Source To Destination",
        "type": "Copy",
        "dependsOn": [],
        "policy": {
            "timeout": "7.00:00:00",
            "retry": 0,
            "retryIntervalInSeconds": 30,
            "secureOutput": false,
            "secureInput": false
        },
        "userProperties": [],
        "typeProperties": {
            "source": {
                "type": "JsonSource",
                "storeSettings": {
                    "type": "AzureBlobFSReadSettings",
                    "recursive": true,
                    "wildcardFileName": "*.json",
                    "enablePartitionDiscovery": false
                },
                "formatSettings": {
                    "type": "JsonReadSettings"
                }
            },
            "sink": {
                "type": "JsonSink",
                "storeSettings": {
                    "type": "AzureBlobFSWriteSettings"
                },
                "formatSettings": {
                    "type": "JsonWriteSettings"
                }
            },
            "enableStaging": false
        },
        "inputs": [
            {
                "referenceName": "${input}",
                "type": "DatasetReference",
                "parameters": {}
            }
        ],
        "outputs": [
            {
                "referenceName": "${output}",
                "type": "DatasetReference",
                "parameters": {}
            }
        ]
    },
    {
        "name": "Call Databricks",
        "type": "DatabricksNotebook",
        "dependsOn": [
            {
                "activity": "Copy From Source To Destination",
                "dependencyConditions": [
                    "Succeeded"
                ]
            }
        ],
        "policy": {
            "timeout": "7.00:00:00",
            "retry": 0,
            "retryIntervalInSeconds": 30,
            "secureOutput": false,
            "secureInput": false
        },
        "userProperties": [],
        "typeProperties": {
            "notebookPath": "${databricks_notebook}",
            "baseParameters": {
                "dataFactory": {
                    "value": "@pipeline().DataFactory",
                    "type": "Expression"
                },
                "pipelineRunId": {
                    "value": "@pipeline().RunId",
                    "type": "Expression"
                }
            }
        },
        "linkedServiceName": {
            "referenceName": "${databricks_linked_service}",
            "type": "LinkedServiceReference"
        }
    }
]