#!/usr/bin/env bash

timeout=15

# Wait for the other container to start accepting connections
sleep 5

# Check if Jupyter notebook returns http status code 200
status=$(curl -o /dev/null -L -X GET --connect-timeout $timeout --max-time $timeout -Isw '%{http_code}\n' http://neural-net-env:8888)

if [[ "$status" -eq "200" ]]; then
  echo 'Jupyter responded with status code 200'
  exit 0
else
  echo "Jupyter did not respond in $timeout seconds"
  exit 1
fi
