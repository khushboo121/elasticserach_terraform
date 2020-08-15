#!/bin/bash

# Script used to set up a new node inside an Elasticsearch cluster in AWS

yum update -y

# Java 8 Installation
yum install java -y
yum install wget -y
wget  https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.7.2.noarch.rpm
yum install elasticsearch-1.7.2.noarch.rpm -y
rm -f elasticsearch-1.7.2.noarch.rpm

echo ES_JAVA_OPTS="\"-Xms1g -Xmx1g\"" >> /etc/sysconfig/elasticsearch
echo MAX_LOCKED_MEMORY=unlimited >> /etc/sysconfig/elasticsearch

# Discovery EC2 plugin is used for the nodes to create the cluster in AWS
echo -e "yes\n" | /usr/share/elasticsearch/bin/elasticsearch-plugin install discovery-ec2

# Shortest configuration for Elasticsearch nodes to find each other
echo "discovery.zen.hosts_provider: ec2" >> /etc/elasticsearch/elasticsearch.yml
echo "cloud.aws.region: us-east-1" >> /etc/elasticsearch/elasticsearch.yml
echo "network.host: [_local_,_site_,_global_]" >> /etc/elasticsearch/elasticsearch.yml

sudo chkconfig --add elasticsearch

sudo service elasticsearch start

echo "Node setup finished!" > ~/terraform.txt
