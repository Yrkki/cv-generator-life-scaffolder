#!/bin/bash

echo $'\033[1;33m'Running script switcher
echo ------------------------------------------------------$'\033[1;33m'
echo

echo $'\033[0;33m'Starting switcher...$'\033[0m'
echo
pwd=$(pwd)
pwd
ls -aF --color=always
echo

apps=(cv-generator-fe cv-generator-fe-eu)

for i in "${!apps[@]}"; do
    app=${apps[$i]}
    echo $'\033[1;30m'Processing the $'\033[0;35m'$app$'\033[1;30m' app...$'\033[0m'

    isOff=$(heroku scale -a $app)

    if [ $isOff == "web=0:Free" ]; then
        heroku scale web=1 -a $app
        heroku maintenance:off -a $app
    else
        heroku maintenance:on -a $app
        heroku scale web=0 -a $app
    fi

    echo
done

echo
echo $'\033[1;32m'Switcher finished.$'\033[0m'

echo
# read  -n 1 -p "x" input
# exit
