## Setar chaves para 400 no windows


icacls.exe key.pem /reset

icacls.exe key.pem /grant:r "$($env:username):(r)"

icacls.exe key.pem /inheritance:r


## Instalar cloudwatch agent

```ps1
https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/install-CloudWatch-Agent-on-EC2-Instance-fleet.html

Depois de insalado execute o comando

& $Env:ProgramFiles\Amazon\AmazonCloudWatchAgent\amazon-cloudwatch-agent-ctl.ps1 -m ec2 -a start

```
