#### Create a policy

```py

{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:eu-west-1:ID-DA-SUA-CONTA:log-group:/aws/lambda/StartFrontofficeASG:*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "sns:*",
                "ec2:*",
                "autoscaling:*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "arn:aws:logs:eu-west-1:ID-DA-SUA-CONTA:*"
        }
    ]
}

```

## Lambda Config
![image](https://user-images.githubusercontent.com/91738714/210440049-0c19ebd2-e517-41f8-bcb1-de68f23c0ad0.png)


######## Start Ec2
``` py
import os
import boto3

client = boto3.client('autoscaling')
client_sns = boto3.client('sns')
ec2 = boto3.resource('ec2')

def get_env_variable(var_name):
    msg = "Set the %s environment variable"
    try:
        return os.environ[var_name]
    except KeyError:
        error_msg = msg % var_name

def lambda_handler(event, context):
    std_srv_name = get_env_variable('STDNAMES').split()
    for std_n_tag in std_srv_name:
        instances = ec2.instances.filter(Filters=[{'Name':'tag:Name', 'Values':[std_n_tag]}])
        for i in instances:
            inst_id = i.id
            ec2.instances.filter(InstanceIds=[inst_id]).start()
            client_sns.publish(TopicArn=get_env_variable('TOPIC_ARN'),Message="Standalone Server"+" " + std_n_tag + " " + "is" +" " + "starting" +" " + "now.")
            
    asg_name_tag = get_env_variable('NAME').split()
    for asg_n_tag in asg_name_tag:
        paginator = client.get_paginator('describe_auto_scaling_groups')
        page_iterator = paginator.paginate(
            PaginationConfig={'PageSize': 10}
        )

        filtered_asgs = page_iterator.search(
            'AutoScalingGroups[] | [?contains(Tags[?Key==`{}`].Value, `{}`)]'.format(
                'Name', asg_n_tag)
        )

        for asg in filtered_asgs:
            group = asg['AutoScalingGroupName']
            action = "Starting"
            min_size = int(get_env_variable('MIN_SIZE'))
            desired_capacity = int(get_env_variable('DESIRED_CAPACITY'))
        
            response = client.update_auto_scaling_group(
                AutoScalingGroupName=group,
                MinSize=min_size,
                DesiredCapacity=desired_capacity,
        )
        
        client_sns.publish(TopicArn=get_env_variable('TOPIC_ARN'),Message="ASG Group"+" " + asg_n_tag + " " + "is" +" " + action +" " + "now.")
```
Stop instance
```py
import os
import boto3

client = boto3.client('autoscaling')
client_sns = boto3.client('sns')
ec2 = boto3.resource('ec2')

def get_env_variable(var_name):
    msg = "Set the %s environment variable"
    try:
        return os.environ[var_name]
    except KeyError:
        error_msg = msg % var_name

def lambda_handler(event, context):
    asg_name_tag = get_env_variable('NAME').split()
    for asg_n_tag in asg_name_tag:
        paginator = client.get_paginator('describe_auto_scaling_groups')
        page_iterator = paginator.paginate(
            PaginationConfig={'PageSize': 10}
        )

        filtered_asgs = page_iterator.search(
            'AutoScalingGroups[] | [?contains(Tags[?Key==`{}`].Value, `{}`)]'.format(
                'Name', asg_n_tag)
        )

        for asg in filtered_asgs:
            group = asg['AutoScalingGroupName']
            action = "Stopping"
            min_size = 0
            desired_capacity = 0
            
            response = client.update_auto_scaling_group(
                AutoScalingGroupName=group,
                MinSize=min_size,
                DesiredCapacity=desired_capacity,
            )
    
            client_sns.publish(TopicArn=get_env_variable('TOPIC_ARN'),Message="ASG Group"+" " + asg_n_tag + " " + "is" +" " + action +" " + "now.")
            
    std_srv_name = get_env_variable('STDNAMES').split()
    for std_n_tag in std_srv_name:
        instances = ec2.instances.filter(Filters=[{'Name':'tag:Name', 'Values':[std_n_tag]}])
        for i in instances:
            inst_id = i.id
            ec2.instances.filter(InstanceIds=[inst_id]).stop()
            client_sns.publish(TopicArn=get_env_variable('TOPIC_ARN'),Message="Standalone Server"+" " + std_n_tag + " " + "is" +" " + "stopping" +" " + "now.")

```

#########
#### Environmet variable
DESIRED_CAPACITY </br>
MIN_SIZE  </br>
NAME  </br>
STDNAMES  </br>
TOPIC_ARN  </br>


########## Permissões


![image](https://user-images.githubusercontent.com/91738714/210439826-445f7038-9e0e-4868-b1a4-4df6da9bb366.png)
