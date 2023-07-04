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

### Describe snapshot from volumes
```sh
aws ec2 describe-snapshots --filters "Name=volume-id, Values=vol-0eb08ccc5bc2c9691,vol-0c8e743d6abf333a2,vol-0cbf19f94d5b023b0,vol-065d958fab766fc79,vol-093708e5ffebf435f"
```
