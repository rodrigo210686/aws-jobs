### Creating a new user

adduser ssettih
su - ssettih
ssh-keygen -f /home/ssettih/.ssh/ -q -P ""
cd /home/ssettih/.ssh/
touch authorized_keys
cat<<EOF> authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1EecSoVxXyozlV+gmTuFcUhXN+NAY3kLkBMWDfabFAeLsxeKz4mPEch9vTebxgpcr9ooJ/Zz+O+EMGBDBd8kz/6osoQF4msXN/NaU6wU3H8leKMSxU5UzFAh5IrXC5ZoxSN/2B90O5f8HwctQdORKeewResDp2m+E7opYp0L5wXk3ShPya9P+4fWCDx36yt5eVZkBM0KUw49l/oITkbI7ZPWgRQiJ+R3dM0H3XyfofwTaPVsf8HblKysLC3jeqf1zI3H4Wt+/0hxwQWjUKTwSrOPXne1GmbmkHSoAzpxkR/TGZ20PkVmlIl/zPqBSJjrWAOsWlcS1LlpFIfCVwqxV settih@ITMMACW00833
EOF
chmod 600 authorized_keys

##
