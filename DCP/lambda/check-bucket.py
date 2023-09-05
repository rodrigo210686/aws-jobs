import boto3
import sys
from datetime import date,time,datetime,timedelta,timezone
s3 = boto3.resource('s3')
s4 = boto3.client('s3')
utc_dt = datetime.now(timezone.utc) # UTC time
dt = utc_dt.astimezone() # local time

def lambda_handler(event, context):

    contents = s4.list_objects_v2(Bucket='gseb-dcp-preprod-backups-solr8',  MaxKeys=1000, Prefix='Preprod/preprod')['Contents']
    
    list1 = []
    list1 = ["comment", "content", "dataref", "profile", "recipe_226", "recipe", "semanticImprover"]
    list2 = []
    sep = str(202)
    
    for c in contents:
    	ref1 = c['LastModified']
    	name = c['Key']
    	file = (name.split('_',1)[1]).split(sep,1)[0]
    	utc_dt = datetime.now(timezone.utc) # UTC time
    	dt = utc_dt.astimezone() # local time
    	ref2 = dt.replace(microsecond=0)
    	ref3 = ref1 + timedelta(hours = 3)
    	print(ref2)
    	print(ref3)
    	if ref3 > ref2:
    	    print("fichier présent", file)
    	    list2.append(file)

    list1.sort()
    list2.sort()
    print(list1)
    if(list1==list2):
        print("Toutes les sauvegardes des collections sont bien présentes sur le bucket")
    else:
        print("Il manque une ou plusieurs collections")
        exit(99)
    
