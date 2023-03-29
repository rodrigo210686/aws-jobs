Em alguns casos ao tentar montar um volume é apresentado erro pois os UID dos discos são iguais.
Para montar use mo comando abaixo
https://serverfault.com/questions/948408/mount-wrong-fs-type-bad-option-bad-superblock-on-dev-xvdf1-missing-codepage
# mount -t xfs -o nouuid /dev/nvme1n1 /mnt


# Volumes novos
https://www.tecmint.com/add-new-disk-to-an-existing-linux/

