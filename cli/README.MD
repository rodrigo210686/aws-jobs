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
