#!/usr/bin/env bash

# check for empty
if [ "$#" -lt 2 ] && [ "$1" != "list" ]; then
  echo "usage \`service [daemon] [start|stop|restart]\` or \`service list\` to see all the daemons"
  exit 1
fi

[[ "$#" -lt 2 ]] && command=$1 || command="${2} ${1}"

brew services $command
