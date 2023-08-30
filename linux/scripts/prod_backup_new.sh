#!/bin/sh
#Author : Yann BLOT
#Prod Backup
#Old version prod_backup.sh.old - don't work anymore because of lack of throughput
#new version to do it on the right instance
##############################################################""
TAG_NAME="Name"
INSTANCE_ID="`wget -qO- http://instance-data/latest/meta-data/instance-id`"
REGION="`wget -qO- http://instance-data/latest/meta-data/placement/availability-zone | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
TAG_VALUE="`aws ec2 describe-tags --filters "Name=resource-id,Values=$INSTANCE_ID" "Name=key,Values=$TAG_NAME" --region $REGION --output=text | cut -f5`"
echo $TAG_VALUE
LEADER=`curl -iv "http://localhost:8983/solr/admin/collections?action=CLUSTERSTATUS" | tail -35 | grep -B4 "leader" | grep "node_name" | cut -c 30-40 | sed 's/prd/prod/g' | sed 's/\./-/g'`
echo $LEADER
if [ "$LEADER" = "$TAG_VALUE" ]
then
        echo "c'est le leader donc le backup est à faire sur cette instance"
else
        echo "pas le leader donc pas de backup sur cette instance"
        exit 99
fi

if [ ! -d /etc/ofs/solr8-cluster/efs-data/solr_backups_prod ]
then
        echo "File doesn't exist. Creating now"
        mkdir /etc/ofs/solr8-cluster/efs-data/solr_backups_prod
        echo "File created"
else
        echo "File exists"
fi

#let solr write on this folder
chown solr:solr /etc/ofs/solr8-cluster/efs-data/solr_backups_prod

#Check and cleanup old backup folders and tar files
for a in recipe comment content profile dataref semanticImprover recipe_226
do
        file=$(ls -lrth /etc/ofs/solr8-cluster/efs-data/solr_backups_prod | grep $a | awk '{print $9}')
        rm /etc/ofs/solr8-cluster/efs-data/solr_backups_prod/$file
done

#For loop inplemented for Backup and pushing the backups to S3 and clean-up of EFS
for a in recipe comment content profile dataref semanticImprover recipe_226
do
        echo "$a"
        curl -iv -X POST 'http://localhost:8983/solr/admin/collections?name=prod_'"$a"''"$(date +%Y%m%d-%H%M)"'&action=BACKUP&collection='"$a"'&location=/etc/ofs/solr8-cluster/efs-data/solr_backups_prod'
        sleep 15
        file=$(ls -lrth /etc/ofs/solr8-cluster/efs-data/solr_backups_prod | grep $a | awk '{print $9}')
        cd /etc/ofs/solr8-cluster/efs-data/solr_backups_prod/
        tar -cf $file.tar $file
        sleep 15
        aws s3 cp /etc/ofs/solr8-cluster/efs-data/solr_backups_prod/$file.tar s3://gseb-dcp-prod-backups-data/Prod/$file.tar
        aws s3 cp /etc/ofs/solr8-cluster/efs-data/solr_backups_prod/$file.tar s3://gseb-dcp-prod-backups-data/Archives/Prod/$file.tar
        rm -rf /etc/ofs/solr8-cluster/efs-data/solr_backups_prod/$file*
done
