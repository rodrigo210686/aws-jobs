Em alguns casos ao tentar montar um volume é apresentado erro pois os UID dos discos são iguais.
Para montar use mo comando abaixo

# mount -t xfs -o nouuid /dev/nvme1n1 /mnt
