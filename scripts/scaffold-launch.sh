#!/bin/bash

echo $'\033[1;33m'Running script scaffold-launch
echo ------------------------------------------------------
echo

echo Scaffolder launch starting...$'\033[0m'
pwd=$(pwd)
pwd
ls -F --color=always
echo


cvgRoot=$1
# echo cvgRoot= $cvgRoot

. ./scaffold-define.sh $cvgRoot

echo $'\033[0;32m'Switching to root directory:$'\033[0m'
cd $cvgRoot
pwd
ls -F --color=always
echo

echo $'\033[0;32m'Switching to application directory:$'\033[0m'
mkdir -p $appName
cd $appName
pwd
ls -F --color=always
echo

# serve application
if $build; then
  echo $'\033[0;32m'Building application...$'\033[0m'
  npm run build
  echo '  ' $'\033[1;30m'Application built.$'\033[0m'
  echo
fi
if $test; then
  echo $'\033[0;32m'Testing application...$'\033[0m'
  npm run test-once
  echo '  ' $'\033[1;30m'Application tested.$'\033[0m'
  echo
fi
if $lint; then
  echo $'\033[0;32m'Linting application...$'\033[0m'
  npm run lint
  echo '  ' $'\033[1;30m'Application linted.$'\033[0m'
  echo
fi
if $e2e; then
  echo $'\033[0;32m'End-to-end testing application...$'\033[0m'
  npm run e2e
  echo '  ' $'\033[1;30m'Application end-to-end tested.$'\033[0m'
  echo
fi
if $doc; then
  echo $'\033[0;32m'Documenting application...$'\033[0m'
  npm run dev:test:document:package:action
  echo '  ' $'\033[1;30m'Application documented.$'\033[0m'
  echo
fi
if $open; then
  echo $'\033[0;32m'Serving and opening application...$'\033[0m'
  npm run open
  echo '  ' $'\033[1;30m'Application served and opened.$'\033[0m'
  echo
elif $serve; then
  echo $'\033[0;32m'Serving application...$'\033[0m'
  npm run start
  echo '  ' $'\033[1;30m'Application served.$'\033[0m'
  echo
fi


echo $'\033[1;30m'Restoring directory...$'\033[0m'
cd $pwd
pwd
ls -F --color=always
echo

SCAFFOLD_TRANSFORM_TASK_PID=$!
echo $'\033[0;33m'Scaffolder launch finished...$'\033[0m'

echo
# read  -n 1 -p "x" input
# exit