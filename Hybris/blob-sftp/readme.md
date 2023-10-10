#### Install Rclone
https://help.sap.com/docs/SAP_COMMERCE_CLOUD_PUBLIC_CLOUD/403d43bf9c564f5a985913d1fbfbf8d7/01cf571d9d93478cb08c6b3dc7008ccd.html

https://rclone.org/commands/rclone_mount/#rclone-as-unix-mount-helper

### Configure rclone
/root/.config/rclone/rclone.conf

```sh
[rodrigo2186]
type = azureblob
account = rodrigo2186
key = jCaG08ooaaGaSW98fU+3Iy4pFiWkbp8ijWs8zEx7RMl1qPxPVRRMkEKftn3XghjFgSc96Bxlp1K2+AStdYpuBQ==
```

### crie um volume
```sh
mkdir -p /efs-sync/efs-recette1/interfaces
```

#### mount volume usando rclone

rclone mount -v --debug-fuse --allow-other --vfs-cache-mode full --vfs-cache-max-age 10s --dir-cache-time 10s --daemon rodrigo2186:recette/interfaces /efs-sync/efs-recette1/interfaces


### mount in boot
#### CRONTAB
@reboot /etc/init.d/blobs.sh

```sh
#!/bin/bash

rclone mount -v --debug-fuse --allow-other --vfs-cache-mode full --vfs-cache-max-age 10s --dir-cache-time 10s --daemon recette1:recette1 /efs-sync/efs-recette1/interfaces
rclone mount -v --debug-fuse --allow-other --vfs-cache-mode full --vfs-cache-max-age 10s --dir-cache-time 10s --daemon recette3:recette3 /efs-sync/efs-recette3/interfaces

### in case mount error use comand below to umont the path and remount usin script above.
#fusermount -uz /efs-sync/efs-recette1/interfaces
```
#### CRIA Container (optional) usando rclone
rclone mkdir rodrigo2186:recette1

