## Examples

```sh
#!/bin/bash
INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
IP_DYNAMIC=$(ip address show dev ens5 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
REGION=`curl http://169.254.169.254/latest/dynamic/instance-identity/document|grep region|awk -F\" '{print $4}'`
ENV=$(aws ec2 describe-tags --region $REGION --filter ""Name=resource-id,Values=$INSTANCE_ID"" --output=text | sed -r 's/TAGS\t(.)\t.\t.\t(.)/\1=""\2""/' | grep CMDB_Environment | awk '{print $5}')
APPLICATION=$(aws ec2 describe-tags --region $REGION --filter ""Name=resource-id,Values=$INSTANCE_ID"" --output=text | sed -r 's/TAGS\t(.)\t.\t.\t(.)/\1=""\2""/' | grep CMDB_Application-solution | awk '{print $5}')
ASG=$(aws ec2 describe-tags --region $REGION --filter ""Name=resource-id,Values=$INSTANCE_ID"" --output=text | sed -r 's/TAGS\t(.)\t.\t.\t(.)/\1=""\2""/' | grep autoscaling:groupName | awk '{print $5}')
### UPDATE FILE /etc/zabbix/zabbix_agentd.conf
sed -i ""s/INSTANCE_ID/$INSTANCE_ID/g"" /etc/zabbix/zabbix_agentd.conf
sed -i ""s/IP_DYNAMIC/$IP_DYNAMIC/g"" /etc/zabbix/zabbix_agentd.conf
sed -i ""s/REGION/$REGION/g"" /etc/zabbix/zabbix_agentd.conf
sed -i ""s/ENV/$ENV/g"" /etc/zabbix/zabbix_agentd.conf
sed -i ""s/APPLICATION/$APPLICATION/g"" /etc/zabbix/zabbix_agentd.conf
sed -i ""s/ASG/$ASG/g"" /etc/zabbix/zabbix_agentd.conf
#START ZABBIX AND ENABLE ZABBIX AGENT
systemctl start zabbix-agent.service
systemctl enable zabbix-agent.service
ausearch -c 'zabbix_agentd' --raw | audit2allow -M my-zabbixagentd && semodule -i my-zabbixagentd.pp
systemctl stop zabbix-agent.service
systemctl start zabbix-agent.service
systemctl status zabbix-agent.service

```
