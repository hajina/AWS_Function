#!/bin/sh
yum install -y aws-kinesis-agent
mkdir /tmp/clickstream-log
chmod 777 /tmp/clickstream-log
cd /home/ec2-user
curl -O https://s3.amazonaws.com/anhyobin-analytics/sample-data/sample_data.csv
curl -O https://s3.amazonaws.com/anhyobin-analytics/code/generator.py
