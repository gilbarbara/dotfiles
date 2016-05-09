#!/usr/bin/env bash

# check for empty
if [ "$#" == 0 ] || [ "$#" -lt 2 ]; then
  echo "usage \`service [service] [start|stop|restart]\`"
  exit 1
fi

brew services $2 $1
