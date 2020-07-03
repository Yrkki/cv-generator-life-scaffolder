#!/bin/bash

echo $'\033[1;33m'Running script scaffold
echo ------------------------------------------------------
echo

echo Starting scaffolder...$'\033[0m'
pwd=$(pwd)
pwd
ls -F --color=always
echo


cvgRoot=$pwd/'../..'

. $pwd/scaffold-generate.sh $cvgRoot
. $pwd/scaffold-transform.sh $cvgRoot
. $pwd/scaffold-launch.sh $cvgRoot


echo $'\033[1;30m'Restoring directory...$'\033[0m'
cd $pwd
pwd
ls -F --color=always
echo

SCAFFOLDER_TASK_PID=$!
echo $'\033[0;33m'Scaffolder finished...$'\033[0m'

echo
# read  -n 1 -p "x" input
# exit
