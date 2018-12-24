#!/bin/bash
set -Ceu

SCRIPT_PATH=$(cd $(dirname $0) && pwd)
SCRIPT_NAME=$(basename $0)


echo ${SCRIPT_PATH}
echo ${SCRIPT_NAME}
echo $$

timeout 10 python hoge.py 
# timeout 10 ./hoge.sh
