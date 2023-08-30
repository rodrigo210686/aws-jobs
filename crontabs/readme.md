## List of crontrab usage

```sh
## Solr start
@reboot (sleep 300 ; /root/solr.sh >> /root/solr.log)

#Backup Job
0 18 * * 5 /bin/sh /root/preprod_backup.sh > /var/log/solr8_backup/solr8-`/bin/date +\%Y\%m\%d`.log 2>&1![image](https://github.com/rbarbosa-inetum/comandos/assets/91738714/632591bb-93e7-4d02-a3ec-f618b854ff1d)

```
