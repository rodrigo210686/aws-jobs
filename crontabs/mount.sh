mount -t efs fs-5bd5ae90.efs.eu-west-1.amazonaws.com:/ /efs
mount --bind /efs/interfaces /home/sftphybris/interfaces
mount --bind /efs/interfaces/IFU /home/ifu/IFU
mount --bind /efs/interfaces/CSS /home/ifu/CSS
mount --bind /efs/maj-properties/conf /home/maj-properties/conf
mount --bind /efs/maj-properties/a_faire /home/maj-properties/a_faire
mount --bind /efs/interfaces /home/eai/interfaces
mount --bind /efs/interfaces/accenture /home/accenture/accenture
