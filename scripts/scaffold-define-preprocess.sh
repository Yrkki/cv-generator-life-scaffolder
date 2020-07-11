#!/bin/bash

echo $'\033[1;33m'Running script scaffold-define-preprocess
echo ------------------------------------------------------
echo

echo Scaffolder define preprocess starting...$'\033[0m'
pwd=$(pwd)
pwd
ls -F --color=always
echo


cvgRoot=$1
# echo cvgRoot= $cvgRoot

pwd=$(pwd)

# echo $'\033[0;32m'Routes:$'\033[0m'
for i in "${!routes[@]}"
do
  route=${routes[$i]}
  # echo $route
  # echo "  " "${route%\/*}" "${route#*\/}"
  modules+=(${route#*\/})
  modulesParent+=(${route%\/*})
done
# echo

echo $'\033[0;32m'Parameters set:$'\033[0m'
echo '  ' $'\033[1;30m'Application name:$'\033[0m' $appName
echo '  ' $'\033[1;30m'Allow routing component?:$'\033[0m' $allowRoutingComponent
echo '  ' $'\033[1;30m'Keep component files?:$'\033[0m' $keepComponentFiles
echo '  ' $'\033[1;30m'Verbose?:$'\033[0m' $verbose
echo '  ' $'\033[1;30m'Generate app?:$'\033[0m' $generateApp
echo '  ' $'\033[1;30m'Classes:$'\033[0m' ${#classes[@]}: "${classes[*]}"
echo '  ' $'\033[1;30m'Components:$'\033[0m' "${#components[@]}": "${components[*]}"
echo '  ' $'\033[1;30m'Enums:$'\033[0m' "${#enums[@]}": "${enums[*]}"
echo '  ' $'\033[1;30m'Guards:$'\033[0m' "${#guards[@]}": "${guards[*]}"
echo '  ' $'\033[1;30m'Interfaces:$'\033[0m' "${#interfaces[@]}": "${interfaces[*]}"
echo '  ' $'\033[1;30m'Modules:$'\033[0m' "${#modules[@]}": "${modules[*]}"
echo '  ' $'\033[1;30m'  Modules parents:$'\033[0m' $'\033[0;37m'"${#modulesParent[@]}": "${modulesParent[*]}"$'\033[0m'
echo '  ' $'\033[1;30m'Routes:$'\033[0m' "${#routes[@]}": "${routes[*]}"
echo '  ' $'\033[1;30m'Pipes:$'\033[0m' "${#pipes[@]}": "${pipes[*]}"
echo '  ' $'\033[1;30m'Services:$'\033[0m' "${#services[@]}": "${services[*]}"
echo


echo $'\033[1;30m'Restoring directory...$'\033[0m'
cd $pwd
pwd
ls -F --color=always
echo

SCAFFOLD_GENERATE_TASK_PID=$!
echo $'\033[0;33m'Scaffolder define preprocess finished...$'\033[0m'

echo
# read  -n 1 -p "x" input
# exit