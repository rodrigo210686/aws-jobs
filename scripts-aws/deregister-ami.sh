### When you try to delete snapshots from console, sometimes you receive a error informing that this snapshot is associated to a AMI. For delete this snapshot you have to delete the AMI.


#/bin/bash

while read p; do
 aws ec2 deregister-image --image-id "$p"
done <ami.txt
