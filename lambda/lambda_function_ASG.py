
from __future__ import print_function
from datetime import datetime, timedelta
import boto3
import os

def lambda_handler(event, context):

        
    try:
        region               = os.environ['region']
        autoScalingGroupName = os.environ['autoScalingGroupName']
        cpuPercent           = os.environ['cpuPercent']            # in Percent
        period               = os.environ['period']                # in secondes
        
        client_as = boto3.client('autoscaling',region_name=region)
        response = client_as.describe_auto_scaling_groups(
                        AutoScalingGroupNames=[autoScalingGroupName]
        )
        autoScalingGroup = response['AutoScalingGroups'][0]

        for instance in autoScalingGroup['Instances'] : 
            instance_id = instance['InstanceId']

            now = datetime.now()
            
            client_cw = boto3.client('cloudwatch',region_name=region)
            response = client_cw.get_metric_statistics(
                Namespace='AWS/EC2',
                MetricName='CPUUtilization',
                Dimensions=[
                    {
                    'Name': 'InstanceId',
                    'Value': instance_id
                    },
                ],
                StartTime=now - timedelta(seconds=period),
                EndTime=now,
                Period=period,
                Statistics=[
                    'Average',
                ],
                Unit='Percent'
            )

            #for cpu_metric in response['Datapoints']
            cpu_metric = response['Datapoints'][0]

            if cpu_metric['Average'] >= cpuPercent :
                ec2 = boto3.client('ec2', region_name=region)

                instanceToDelete = ec2.Instance(instance_id)
                response = instanceToDelete.terminate()


        return 0

    except Exception as erroMSG:
        print("Unexpected error controling AutoScalingGroup : " + erroMSG)
        
        return 1

