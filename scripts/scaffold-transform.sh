#!/bin/bash

echo $'\033[1;33m'Running script scaffold-transform
echo ------------------------------------------------------
echo

echo Scaffolder transform starting...$'\033[0m'
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

componentsPath=$(pwd)'/src/app/modules/**/*.component.*'
echo $'\033[0;32m'Arranging components...$'\033[0m'
for i in $(find $componentsPath -maxdepth 2 -type f)
do
  if [ $keepComponentFiles == true ]; then
    echo '  ' $'\033[0;34m'Moving$'\033[0m' $i $'\033[0;34m'component file:$'\033[0m'
    dest=$(eval echo $i | sed -e 's/modules/components/g')
    mkdir -p $(dirname "${dest}")
    mv -f $i $dest
  else
    echo '  ' $'\033[0;34m'Removing$'\033[0m' $i $'\033[0;34m'component file:$'\033[0m'
    rm -f $i
  fi
done
echo

modulesPath=$(pwd)'/src/app/modules/**/*.module.*'
echo $'\033[0;32m'Editing modules...$'\033[0m'
for i in $(find $modulesPath -maxdepth 1 -type f)
do
  echo '  ' $'\033[0;34m'Editing$'\033[0m' $i $'\033[0;34m'module file:$'\033[0m'

  moduleName=$(eval echo $(basename "${i%%.*}") | sed -e 's/-routing//g')

  echo '    ' $'\033[0;35m'Processing module components:$'\033[0m' $moduleName$'\033[1;30m'.$'\033[0m'
  if [ $allowRoutingComponent == true ]; then
    if [[ ! $i == *"-routing"* ]]; then
      # classify
      moduleClassified=$(echo "$moduleName" \
        | sed 's/-\([a-z]\)/\U\1/g;s/^\([a-z]\)/\U\1/g')
      # echo '      ' $moduleClassified

      # duplicate component declaration line
      sed -i -e "s/\(^import.*\)$moduleClassified\(Component.*\)\(';$\)/\1"$moduleClassified"Component as "$moduleClassified"Base\2\3\n\1$moduleClassified\2\3/g" $i
      echo '      ' $'\033[1;30m'Component declaration line duplicated.$'\033[0m'

      # duplicate component module declarations membership
      sed -i -e "s/\(declarations: \[.*\)$moduleClassified\(.*$\)/\1"$moduleClassified"BaseComponent, $moduleClassified\2/g" $i
      echo '      ' $'\033[1;30m'Component module declarations membership duplicated.$'\033[0m'
    fi

    # reroute module components
    sed -i -e "s/\.\/$moduleName.component/..\/..\/components\/$moduleName\/$moduleName.component/g" $i
    sed -i -e "/ as /! s/$moduleName.component/$moduleName.component.routing/g" $i
  else
    # reroute module components
    sed -i -e "s/\.\/$moduleName.component/..\/..\/components\/$moduleName\/$moduleName.component/g" $i
  fi
  echo '      ' $'\033[1;30m'Module components rerouted.$'\033[0m'
done
echo


echo $'\033[1;30m'Restoring directory...$'\033[0m'
cd $pwd
pwd
ls -F --color=always
echo

SCAFFOLD_TRANSFORM_TASK_PID=$!
echo $'\033[0;33m'Scaffolder transform finished...$'\033[0m'

echo
# read  -n 1 -p "x" input
# exit