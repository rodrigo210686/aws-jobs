# Enable/Disable Event Bridgre Rules from EventBridge Schedule

### First Create role a custom role usign AWS cli

Ref: https://docs.aws.amazon.com/scheduler/latest/UserGuide/setting-up.html


### Cria um arquivo chamado Scheduler-Execution-Role.json com conteúdo abaixo.
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "scheduler.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
```
### Executa o comando abaixo para criar a role
aws iam create-role --role-name InetumSchedulerExecutionRole --assume-role-policy-document file://Scheduler-Execution-Role.json

### Second create the policy to allow EventSchedulle enable/disable eventBridge Rules

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
### Associe a policy criada anteirormente à ROLE criada via CLI + a policy padrão AmazonEventBridgeSchedulerFullAccess

