## CHECK DNS
if you need, I have an AWS CLI command to list all DNS from an account :

 
```sh
Alias from the account

aws cloudfront list-distributions --query "DistributionList.Items[*].Aliases.Items[*]" --output yaml

 

Alias with Cloudfront ID

aws cloudfront list-distributions --query "DistributionList.Items[*].[Id,Aliases.Items[*]]" --output yaml

 

Alias with Cloudfront Origin

aws cloudfront list-distributions --query "DistributionList.Items[*].[Id,Aliases.Items[*],Origins.Items[*].{id:Id,name:DomainName}]" --output yaml

```


### Increase RDS disk
Quando o disco da instância está como storage-full apresenta erro para aumentar disco e é necessário realizar através de cli

```sh

aws rds modify-db-instance --db-instance-identifier (nome-da-instancia) --allocated-storage (valor em GB) --apply-immediately
aws rds modify-db-instance --db-instance-identifier htst-sebdcp --allocated-storage 10 --apply-immediately
```
