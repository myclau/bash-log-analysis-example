#!/bin/bash

# convert example.json into space separated format: <dnsNames> <notBefore> <notAfter>
# output should be as followed:
# foo.com 2022-08-04T01:40:09Z 2022-11-02T01:40:08Z
# bar.com,baz.com 2022-08-04T01:38:11Z 2022-11-02T01:38:10Z

source="./example.json"


result_length=$(cat $source | jq '.items | length')

for ((i=0;i<$result_length;i++))
do
temp_result_dnsNames=$(cat $source | jq -c ".items[$i].spec.dnsNames")
temp_result_dnsNames=${temp_result_dnsNames//\[/}
temp_result_dnsNames=${temp_result_dnsNames//\]/}
temp_result_dnsNames=${temp_result_dnsNames//\"/}
temp_result_notBefore=$(cat $source | jq -r ".items[$i].status.notBefore")
temp_result_notAfter=$(cat $source | jq -r ".items[$i].status.notAfter")

echo "$temp_result_dnsNames $temp_result_notBefore $temp_result_notAfter"
done