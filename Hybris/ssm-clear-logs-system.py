aws ssm send-command --document-name "AWS-RunShellScript" --document-version "1" \
--targets Key=tag:Name,Values=Hybris-storefront3-PRODUCTION \
--parameters '{"workingDirectory":[""],"executionTimeout":["3600"],"commands":["> /var/log/messages-20231203","> /var/log/messages"]}' \
--timeout-seconds 600 --max-concurrency "50" --max-errors "0" \
--region eu-west-1
