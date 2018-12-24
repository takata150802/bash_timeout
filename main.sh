#!/bin/bash
set -Ceu

SCRIPT_PATH=$(cd $(dirname $0) && pwd)
SCRIPT_NAME=$(basename $0)


echo ${SCRIPT_PATH}
echo ${SCRIPT_NAME}
echo $$

python hoge.py &
TGT_PID=$!
sleep 5 &
TIM_PID=$!

echo "TGT_PID: "${TGT_PID}
echo "TIM_PID: "${TIM_PID}



wait
echo "eof"
