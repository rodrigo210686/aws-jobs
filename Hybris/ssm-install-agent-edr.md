
```sh
aws ssm send-command --document-name "AWS-RunShellScript" --document-version "1" \
--targets Key=tag:Component,Values=solr \
--parameters '{"workingDirectory":[""],"executionTimeout":["3600"],"commands":["aws s3 cp s3://inetum-log-test1/agent.sh /tmp","chmod +x /tmp/agent.sh","/tmp/agent.sh"]}' \
--timeout-seconds 600 --max-concurrency "50" --max-errors "0" \
--region eu-west-1

```
