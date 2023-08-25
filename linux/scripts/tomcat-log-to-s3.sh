
root@ip-10-160-47-160:~# vim  /usr/local/sbin/copy_log_files_to_s3.sh
#! /bin/bash
set -x

#exec 2>>/tmp/log.$$

export AWS_DEFAULT_REGION="eu-west-1"
ENV="production"
APP="tomcat"
LOG_DIR="/var/log/tomcat9"
# Take the first of all IP addresses: On EC2 there is only one anyways,
# for local tests there might be multiple (eth, wifi, tun) and eth0 is supposed to be the first one.
HOST_IP="$(hostname -I | awk '{ print $1 }')"
S3_BUCKET_URI="seb-robart"
S3_TARGET_URI="${S3_BUCKET_URI}/${ENV}/${APP}/${HOST_IP}/"

# Create the bucket
#aws s3 mb "${S3_BUCKET_URI}" --region "${AWS_DEFAULT_REGION}"

# Copy all compressed log files to S3
for F in $(ls -1 $LOG_DIR/*20*) ; do

        # Compress manually, as logrotate is instructed not to compress.
        gzip "$F"
        COMPRESSED_F="$F.gz"

        aws s3 cp "$COMPRESSED_F" "s3://$S3_TARGET_URI"

        if [ $? -eq 0 ]; then
                rm -rfv "$COMPRESSED_F"
        fi
done
