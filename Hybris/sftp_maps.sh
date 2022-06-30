mount --bind /efs/interfaces/IFU /home/ifu/IFU
mount --bind /efs/interfaces/CSS /home/ifu/CSS
mount --bind /efs/maj-properties/conf /home/maj-properties/conf
mount --bind /efs/maj-properties/a_faire /home/maj-properties/a_faire
mount --bind /efs/interfaces /home/eai/interfaces
mount --bind /efs/interfaces /home/sftphybris/interfaces


######## Diretórios Hybris PROD

´´´shell
root@ip-192-168-152-58 interfaces]# df -h
Filesystem                                                       Size  Used Avail Use% Mounted on
devtmpfs                                                         961M     0  961M   0% /dev
tmpfs                                                            978M     0  978M   0% /dev/shm
tmpfs                                                            978M  720K  977M   1% /run
tmpfs                                                            978M     0  978M   0% /sys/fs/cgroup
/dev/nvme0n1p1                                                   100G  6.9G   94G   7% /
fs-c1d8d609.efs.eu-west-1.amazonaws.com:/                        8.0E  874G  8.0E   1% /efs
fs-c1d8d609.efs.eu-west-1.amazonaws.com:/interfaces              8.0E  874G  8.0E   1% /home/eai/interfaces
fs-c1d8d609.efs.eu-west-1.amazonaws.com:/maj-properties/conf     8.0E  874G  8.0E   1% /home/maj-properties/conf
fs-c1d8d609.efs.eu-west-1.amazonaws.com:/interfaces/CSS          8.0E  874G  8.0E   1% /home/ifu/CSS
fs-c1d8d609.efs.eu-west-1.amazonaws.com:/maj-properties/a_faire  8.0E  874G  8.0E   1% /home/maj-properties/a_faire
fs-c1d8d609.efs.eu-west-1.amazonaws.com:/interfaces/IFU          8.0E  874G  8.0E   1% /home/ifu/IFU
tmpfs                                                            196M     0  196M   0% /run/user/1002
tmpfs                                                            196M     0  196M   0% /run/user/0
fs-c1d8d609.efs.eu-west-1.amazonaws.com:/interfaces              8.0E  874G  8.0E   1% /home/sftphybris/interfaces

´´´
