#!/bin/bash

SCRIPT_PATH=$(cd $(dirname $0) && pwd)
SCRIPT_NAME=$(basename $0)


echo ${SCRIPT_PATH}
echo ${SCRIPT_NAME}
echo $$

### [1] timeout
# timeout 5 ./hoge.sh
### [2] sleep
./hoge.sh &
TGT_PID=$!
sleep 5 &
TIM_PID=$!

echo "TGT_PID: "${TGT_PID}
echo "TIM_PID: "${TIM_PID}

while true; do
    kill -0 ${TGT_PID}
    if [ $? -eq 0 ]; then
        kill ${TIM_PID}
        exit
    fi
    kill -0 ${TIM_PID}
    if [ $? -eq 0 ]; then
        exit
    fi
    sleep 1
done

wait

