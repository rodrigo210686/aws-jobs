#/bin/bash
### When you try to delete snapshots from console, sometimes you receive a error informing that this snapshot is associated to a AMI. For delete this snapshot you have to delete the AMI.
# To delete, get the list of AMI showed in error, check if does not use this AMI anymore, and input the list of AMI that you want to deregister inside a file ami.txt in the same folder from this scritp.
# You can perform it form Amazon CLI

while read p; do
 aws ec2 deregister-image --image-id "$p"
done <ami.txt
