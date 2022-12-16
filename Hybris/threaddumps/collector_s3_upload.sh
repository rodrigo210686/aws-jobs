#!/bin/bash
timestamp()
{
 date +"%Y-%m-%d %T"
}
instance_id=$(curl http://169.254.169.254/latest/meta-data/instance-id)
env=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$instance_id" --region=eu-west-1 --query 'Tags[?Key==`environment`].Value' --output text)
instance_name=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$instance_id" --region=eu-west-1 --query 'Tags[?Key==`Name`].Value' --output text)
threadDumpsDirectoryBase=/home/hybris/hybris/log/tomcat
threadDumpsDirectory=${threadDumpsDirectoryBase}
LOG_FILE="/var/log/collector_s3_upload.log"
exec > >(tee -a $LOG_FILE) # directs stdout to log file
exec 2>&1 # and also to console


#export AWS_ACCESS_KEY_ID=$HEAPDUMP_UP_AWS_ACCESS_KEY_ID
#export AWS_SECRET_ACCESS_KEY=$HEAPDUMP_UP_AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=eu-west-1

NOW=$(date +"%Y%m%d%H%M%S")
expirationDate=$(date -d $(date +"%Y/%m/%"d)+" 30 days" +%Y/%m/%d)

echo "$(timestamp): look for heap dumps to upload "

cd ${threadDumpsDirectory}

for hprof_file in java_gc.*
do
  echo "$(timestamp): Processing $hprof_file file..."
  cp $hprof_file ${hprof_file}-${NOW}
  gzip ${hprof_file}-${NOW}
  aws s3 cp ${hprof_file}-${NOW}.gz "s3://hybrisapplog/${env}/gclogs/${instance_name}_${instance_id}_${NOW}.gz" --expires $expirationDate --acl bucket-owner-full-control
  rm ${hprof_file}-${NOW}.gz
  echo "$(timestamp): upload dump successfuly"

done

echo "$(timestamp): done heap dump loop"
