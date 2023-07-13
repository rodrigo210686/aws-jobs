# Enable/Disable Event Bridgre Rules from EventBridge Schedule

First

Second create the policy to allow EventSchedulle enable/disable eventBridge Rules

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "events:DisableRule",
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "events:EnableRule",
            "Resource": "*"
        }
    ]
}
```

Crie um role associe a policy criada anteirormente mais a policy padrão AmazonEventBridgeSchedulerFullAccess

