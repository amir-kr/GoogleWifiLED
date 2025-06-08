#!/bin/sh


node=$(uci get passwall2.@global[0].node 2>/dev/null)

if [ -z "$node" ]; then
  echo "node is empty or not found"
  exit 1
fi


default_node=$(uci get passwall2."$node".default_node 2>/dev/null)

if [ -n "$default_node" ]; then
  echo "$default_node"
else
  echo "$node"
fi
