#!/bin/bash

function main () {
    SCRIPT_PATH=$(cd $(dirname $0) && pwd)
    SCRIPT_NAME=$(basename $0)
    
    ###  5 sec 経過でタイムアウトする
    ### [1] timeout コマンドを使う##############################################
    # timeout 5 ./hoge.sh
    ### [2] 下記Step1/2を1 sec毎に実行する######################################
    # Step1: kill -0 ${TGT_PID} or ${TIM_PID}でprocessの死活(終了/実行中)を取得
    # Step2: ${TIM_PID}, ${TIM_PID}の終了をOR条件で判定、killする
    # ※  ${TGT_PID}: タイムアウト監視対象のPID
    # ※  ${TIM_PID}: タイマーのPID
    ./hoge.sh &
    TGT_PID=$!
    sleep 5 &
    TIM_PID=$!
    
    err_msg=$(
    echo "${SCRIPT_PATH}/${SCRIPT_NAME}: "
    echo "Process ${TGT_PID} will be killed by ${SCRIPT_NAME}."
    )
    
    while true; do
        kill -0 ${TGT_PID}
        if [ ! $? -eq 0 ]; then
            killtree ${TIM_PID} KILL
            exit
        fi
        kill -0 ${TIM_PID}
        if [ ! $? -eq 0 ]; then
            killtree ${TGT_PID} KILL
            echo ${err_msg}
            exit 1
        fi
        sleep 1
    done
    wait
    ###########################################################################
    exit
}


### kill all members of a process group
function killtree() {
    if [ $# -eq 0 -o $# -gt 2 ]; then
        echo "Usage: $(basename $0) <pid> [signal]"
        exit 1
    fi
    local _pid=$1
    local _sig=${2:-TERM}
    kill -stop ${_pid} # needed to stop quickly forking parent from producing child between child killing and parent killing
    for _child in $(ps -o pid --no-headers --ppid ${_pid}); do
        killtree ${_child} ${_sig}
    done
    kill -${_sig} ${_pid}
}

main
