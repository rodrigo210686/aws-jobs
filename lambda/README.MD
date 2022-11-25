### lambda to delete VM where exists cloudwatch metric where CPU >= 95 % during 600s

Hello.

I make this lambda to delete VM where exists cloudwatch metric where CPU >= 95 % during 600s.

Attention : lambda not tested but easy to adapt 

### Sorry for this late response but i think we can use a lambda with reccurence trigger to list all instances in AutoScalingGroup ,check if CPUutilisation > 95% and delete if necessary. (see the untested lambda attach )

AutoScalingGroup ,check if CPUutilisation > 95% and delete if necessary. (see the untested lambda attach )
