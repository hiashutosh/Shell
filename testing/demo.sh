#!/bin/bash

#passing args in script
echo $0 $1 $2 $3 '> echo $1 $2 $3'

echo "usage: `basename $0` filename"
echo $?
