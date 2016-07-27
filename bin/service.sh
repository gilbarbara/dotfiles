#!/usr/bin/env bash

# check for empty
if [ "$#" == 0 ] || ([ "$#" -lt 2 ] || [ "$2" -ne "list" ]); then
  echo "usage \`service [daemon] [start|stop|restart]\`"
  exit 1
fi

brew services $2 $1
