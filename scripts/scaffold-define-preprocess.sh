#!/bin/bash

echo $'\033[1;32m'Running script scaffold-define-preprocess
echo ------------------------------------------------------
echo

echo Scaffolder define preprocess starting...$'\033[0m'
pwd=$(pwd)
pwd
ls -aF --color=always
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
echo '  ' $'\033[1;30m'Generate app?:$'\033[0m' $generateApp
echo '  ' $'\033[1;30m'Verbose?:$'\033[0m' $verbose
echo '  ' $'\033[1;30m'Allow routing component?:$'\033[0m' $allowRoutingComponent
echo '  ' $'\033[1;30m'Keep component files?:$'\033[0m' $keepComponentFiles
echo '  ' $'\033[1;30m'Mod global angular schematics?:$'\033[0m' $modGlobalSchematics
echo '  ' $'\033[1;30m'Mod local angular schematics?:$'\033[0m' $modLocalSchematics
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
echo '  ' $'\033[1;30m'Start pipeline?:$'\033[0m' $startPipeline
echo '  ' $'\033[1;30m'Serve?:$'\033[0m' $serve
echo '  ' $'\033[1;30m'Open?:$'\033[0m' $open
echo '  ' $'\033[1;30m'Build?:$'\033[0m' $build
echo '  ' $'\033[1;30m'Test?:$'\033[0m' $test
echo '  ' $'\033[1;30m'Lint?:$'\033[0m' $lint
echo '  ' $'\033[1;30m'E2e?:$'\033[0m' $e2e
echo '  ' $'\033[1;30m'Doc?:$'\033[0m' $doc
echo


echo $'\033[1;30m'Restoring directory...$'\033[0m'
cd $pwd
pwd
ls -aF --color=always
echo

SCAFFOLD_GENERATE_TASK_PID=$!
echo $'\033[0;32m'Scaffolder define preprocess finished...$'\033[0m'

echo
# read  -n 1 -p "x" input
# exit