#!/bin/bash


function parse_input() {
  # jq reads from stdin so we don't have to set up any inputs, but let's validate the outputs
  eval "$(jq -r '@sh "export URL=\(.url)"')"
  if [[ -z "${URL}" ]]; then export URL=none; fi
}

parse_input

hosturl="${URL}"
# extract the protocol
proto="$(echo $hosturl | grep :// | sed -e's,^\(.*://\).*,\1,g')"
# remove the protocol
url="$(echo ${hosturl/$proto/})"
# extract the user (if any)
user="$(echo $url | grep @ | cut -d@ -f1)"
# extract the host and port
hostport="$(echo ${url/$user@/} | cut -d/ -f1)"
# by request host without port    
host="$(echo $hostport | sed -e 's,:.*,,g')"
# by request - try to extract the port
#port="$(echo $hostport | sed -e 's,^.*:,:,g' -e 's,.*:\([0-9]*\).*,\1,g' -e 's,[^0-9],,g')"
# extract the path (if any)
#path="$(echo $url | grep / | cut -d/ -f2-)"

#host="${URL}"
echo -n "{\"host\":\"${host}\"}"
#echo -n "{\"host\":\"${URL}\"}"
#echo -n "{\"host\":\"testing\"}"







#END
