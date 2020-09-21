#!/bin/bash

while read arg1; do
  ./2.expect $arg1 || echo 'hello'
done < args.txt
