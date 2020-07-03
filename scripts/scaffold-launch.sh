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
  npm run build
  echo $'\033[0;32m'Application built.$'\033[0m'
fi
if $test; then
  env singleRun=true npm run test -- --code-coverage --watch=false
  echo $'\033[0;32m'Application tested.$'\033[0m'
fi
if $lint; then
  npm run lint
  echo $'\033[0;32m'Application linted.$'\033[0m'
fi
if $e2e; then
  npm run e2e
  echo $'\033[0;32m'Application end-to-end tested.$'\033[0m'
fi
if $serve; then
  if $open; then
    npm run start -- --open=true
    echo $'\033[0;32m'Application opened.$'\033[0m'
  else
    npm run start
    echo $'\033[0;32m'Application served.$'\033[0m'
  fi
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