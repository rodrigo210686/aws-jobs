## Página com todos alertas
https://delivery.inetum.com/confluence/pages/viewpage.action?spaceKey=SRBIG&title=CLO+%3A+Cloud

## Tabelas com a lista de hosts no zabbix
Este link é atualizado automaticamente no confluence: </br>

https://delivery.inetum.com/confluence/display/SRBIG/GSEB+Couverture+de+Supervision

## Cenários WEB
Este link é atualizado automaticamente no confluence: </br>

https://delivery.inetum.com/confluence/display/SRBIG/GSEB+Scenario+Web

## Trigger severity

https://delivery.inetum.com/confluence/display/SRBIG/GSEB+Inventaire+Consigne



## install npm e newman

```sh
curl -sL https://rpm.nodesource.com/setup_17.x | bash -

yum install -y nodejs

yum install gcc-c++ openssl-devel make

yum install npm -y

npm install -g newman


[root@ip-10-160-9-147 newman]# /usr/local/bin/newman run edifixio_collection.json --environment env-aws-prod.json  --globals globals.json --folder 'Probe 9 to 10' --timeout 15000 --ssl-client-cert dcp-prod.2020.crt --ssl-client-key dcp-p
rod.2020.key > newman/check_Recipe_Read_From_Newman_prod.logs



export PATH=$PATH:/usr/local/bin

/etc/profile.d/sh.local
```
