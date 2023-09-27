### Check database

```sh
###To find the InnoDB temporary tablespace, run the following query:

mysql SELECT file_name, tablespace_name, table_name, engine, index_length, total_extents, extent_size FROM information_schema.files WHERE file_name LIKE '%ibtmp%';

### Run the following query to find the InnoDB system tablespace:

mysql SELECT file_name, tablespace_name, table_name, engine, index_length, total_extents, extent_size FROM information_schema.files WHERE file_name LIKE '%ibdata%';
 
 

```


### Criar usuários
```sh
ALTER USER 'hybris'@'%' IDENTIFIED BY 'YhaG6HT8OpTaaG';
FLUSH PRIVILEGES;
```
Read only user
```sh
Password (only on time to retrieve it ) : https://transfer.pw/BM74DBJ0LHxImVS7MBTwSeljB#jVaIxHuo8Qb6A4eF6oWW6eu1e
 
CREATE USER 'sap-readonly'@'%' IDENTIFIED BY '[replace by password]';

GRANT SELECT, SHOW VIEW ON hybris.* TO 'sap-readonly'@'%';

FLUSH PRIVILEGES;

```

https://github.com/groupeseb/InfraIT-AWS-Hybris/blob/develop/jenkins/hybris-infrastructure/envparameters/rollout.sh
https://github.com/groupeseb/InfraIT-AWS-Hybris/blob/develop/configuration/hybris/ROLLOUT/local.properties
