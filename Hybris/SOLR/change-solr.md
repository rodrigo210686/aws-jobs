# SOLR Scripts

``` sh
#USER ROOT
# STOP SOLR
su solr -c '/home/solr/solr/bin/solr stop'
# rename OLD SOLR
mv /home/solr /home/solr-7

# DOWNLOAD FILES
aws s3 cp s3://seb-sysops-hybris-services-eu-west-1/solr/seb-solr-8.11.zip /tmp/
aws s3 cp s3://seb-sysops-hybris-services-eu-west-1/elk/jolokia-jvm-1.7.1.jar /srv/

# UNZIP
unzip /tmp/seb-solr-8.11.zip -d /home/solr
mv /home/solr/solr-8.11.1 /home/solr/solr
chown -R solr:solr /home/solr
chmod +x /home/solr/solr/bin/solr


# configure JOLOKIA
echo 'SOLR_OPTS="$SOLR_OPTS -javaagent:/srv/jolokia-jvm-1.7.1.jar=port=7777,host=localhost"' >>/home/solr/solr/bin/solr.in.sh
echo 'SOLR_OPTS="$SOLR_OPTS -Dsolr.disable.shardsWhitelist=true"' >>/home/solr/solr/bin/solr.in.sh

#COMMON
sudo -u solr aws s3 cp s3://seb-sysops-hybris-services-eu-west-1/configuration/solr/clusterConfig/common/schema.xml /home/solr/solr/server/solr/configsets/backoffice/conf/
sudo -u solr aws s3 cp s3://seb-sysops-hybris-services-eu-west-1/configuration/solr/clusterConfig/common/schema.xml /home/solr/solr/server/solr/configsets/default/conf/

sudo -u solr aws s3 sync s3://seb-sysops-hybris-services-eu-west-1/configuration/solr/clusterConfig/common/lang /home/solr/solr/server/solr/configsets/backoffice/conf/lang --delete
sudo -u solr aws s3 sync s3://seb-sysops-hybris-services-eu-west-1/configuration/solr/clusterConfig/common/lang /home/solr/solr/server/solr/configsets/default/conf/lang --delete

# uncomment lines depending on the environment
#MASTERBO
#sudo -u solr aws s3 cp s3://seb-sysops-hybris-services-eu-west-1/configuration/solr/clusterConfig/backOffice/masterBo/solrconfig.xml /home/solr/solr/server/solr/configsets/backoffice/conf/
#su solr -c 'rm -rf /home/solr/solr/server/solr/configsets/default'

#MASTER FOR ALL CLUSTERS
#sudo -u solr aws s3 cp s3://seb-sysops-hybris-services-eu-west-1/configuration/solr/clusterConfig/frontOffice/master/solrconfig.xml /home/solr/solr/server/solr/configsets/default/conf/
#su solr -c 'rm -rf /home/solr/solr/server/solr/configsets/backoffice'

#SLAVE CLUSTER1
sudo -u solr aws s3 cp s3://seb-sysops-hybris-services-eu-west-1/configuration/solr/clusterConfig/frontOffice/slave/solrconfig.xml /home/solr/solr/server/solr/configsets/default/conf/
su solr -c 'rm -rf /home/solr/solr/server/solr/configsets/backoffice'
sudo -u solr sed -i "s#solr-master.hybris#solr-master.$1.hybris#g" /home/solr/solr/server/solr/configsets/default/conf/solrconfig.xml

#SLAVE CLUSTER2
#sudo -u solr aws s3 cp s3://seb-sysops-hybris-services-eu-west-1/configuration/solr/clusterConfig/frontOffice/slave/solrconfig.xml /home/solr/solr/server/solr/configsets/default/conf/
#su solr -c 'rm -rf /home/solr/solr/server/solr/configsets/backoffice'
#sudo -u solr sed "s#solr-master.hybris#solr-master2.$1.hybris#g" /home/solr/solr/server/solr/configsets/default/conf/solrconfig.xml


#START SOLR
su solr -c "/home/solr/solr/bin/solr start -p 8983 -m 24g"
#UPDATE CRONTAB SCRIPT
echo 'su solr -c "/home/solr/solr/bin/solr start -p 8983 -m 24g"' > /root/solr.sh
```

