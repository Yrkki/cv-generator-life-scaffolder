#!/bin/bash

echo $'\033[1;33m'Running script scaffold-generate
echo ------------------------------------------------------
echo

echo Scaffolder generate starting...$'\033[0m'
pwd=$(pwd)
pwd
ls -F --color=always
echo


cvgRoot=$1
# echo cvgRoot= $cvgRoot

. ./scaffold-define.sh $cvgRoot

ngGenrateClassModPath='\@schematics/angular/class/files/'
ngGenrateClassMod=$(realpath './'$ngGenrateClassModPath'__name@dasherize____type__.ts.template')
ngGenrateComponentModPath='\@schematics/angular/component/files/__name@dasherize@if-flat__/'
ngGenrateComponentMod=$(realpath './'$ngGenrateComponentModPath'__name@dasherize__.__type@dasherize__.routing.ts.template')
ngGenrateModuleModPath='\@schematics/angular/module/files/__name@dasherize@if-flat__/'
ngGenrateModuleMod=$(realpath './'$ngGenrateModuleModPath'__name@dasherize__.module.ts.template')
ngGenrateModuleRoutingMod=$(realpath './'$ngGenrateModuleModPath'__name@dasherize__-routing.module.ts.template')

echo $'\033[0;32m'Switching to root directory:$'\033[0m'
cd $cvgRoot
pwd
ls -F --color=always
echo

# # ng generate appShell
# # ng generate application
# ng generate class
# # ng generate component
# # ng generate directive
# # ng generate enum
# ng generate guard
# # ng generate interceptor
# ng generate interface
# # ng generate library
# ng generate module
# ng generate pipe
# ng generate service

echo $'\033[0;32m'Generating app:$'\033[0m'
if [ $generateApp == true ]; then
  # echo Generating app:
  ng new $appName \
    --defaults=true \
    --dryRun=false \
    --force=true \
    --help=false \
    --interactive=false \
    \
    --commit=false \
    --createApplication=true \
    --packageManager=npm \
    --prefix=app \
    --routing=true \
    --skipGit=false \
    --skipInstall=false \
    --skipTests=false \
    --strict=true \
    --style=scss \
    --verbose=false \
    \
    1> /dev/null
fi
echo

echo $'\033[0;32m'Switching to application directory:$'\033[0m'
mkdir -p $appName
cd $appName
pwd
ls -F --color=always
echo

echo $'\033[0;32m'Modding the ng generate commands...$'\033[0m'
cp -v $ngGenrateClassMod './node_modules/'$ngGenrateClassModPath
echo
cp -v $ngGenrateComponentMod './node_modules/'$ngGenrateComponentModPath
echo
cp -v $ngGenrateModuleMod './node_modules/'$ngGenrateModuleModPath
echo
cp -v $ngGenrateModuleRoutingMod './node_modules/'$ngGenrateModuleModPath
echo '  ' $'\033[1;30m'Ng generate commands modded.$'\033[0m'
echo

echo $'\033[0;32m'Generating ${#classes[@]} classes:$'\033[0m'
for i in "${!classes[@]}"
do
  echo '  ' $'\033[0;34m'Generating$'\033[0m' ${classes[$i]} $'\033[0;34m'class \($((i+1)) of ${#classes[@]}\):$'\033[0m'
  ng generate class classes/${classes[$i]}/${classes[$i]} \
    --defaults=true \
    --dryRun=false \
    --force=true \
    --help=false \
    --interactive=false \
    \
    --lintFix=true \
    --skipTests=false \
    \
    1> /dev/null
    # --project=project \
    # --type=type \
done
echo

echo $'\033[0;32m'Generating ${#components[@]} components:$'\033[0m'
for i in "${!components[@]}"
do
  echo '  ' $'\033[0;34m'Generating$'\033[0m' ${components[$i]} $'\033[0;34m'component \($((i+1)) of ${#components[@]}\):$'\033[0m'
  :
done
echo

echo $'\033[0;32m'Generating ${#guards[@]} guards:$'\033[0m'
for i in "${!guards[@]}"
do
  echo '  ' $'\033[0;34m'Generating$'\033[0m' ${guards[$i]} $'\033[0;34m'guard \($((i+1)) of ${#guards[@]}\):$'\033[0m'
  ng generate module guards/${guards[$i]}/${guards[$i]} \
    --defaults=true \
    --dryRun=false \
    --force=true \
    --help=false \
    --interactive=false \
    \
    --flat=false \
    --lintFix=true \
    --skipTests=false \
    \
    1> /dev/null
    # --interface \
    # --project=project \
done
echo

echo $'\033[0;32m'Generating ${#interfaces[@]} interfaces:$'\033[0m'
for i in "${!interfaces[@]}"
do
  echo '  ' $'\033[0;34m'Generating$'\033[0m' ${interfaces[$i]} $'\033[0;34m' interface \($((i+1)) of ${#interfaces[@]}\):$'\033[0m'
  ng generate interface interfaces/${interfaces[$i]} \
    --defaults=true \
    --dryRun=false \
    --force=true \
    --help=false \
    --interactive=false \
    \
    --lintFix=true \
    \
    1> /dev/null
    # --prefix=prefix \
    # --project=project \

  echo '    ' $'\033[0;35m'Registering ${interfaces[$i]} interface with parent class:$'\033[0m'
  echo '      ' $'\033[1;30m'TODO...$'\033[0m'
done
echo

echo $'\033[0;32m'Generating ${#modules[@]} modules:$'\033[0m'

echo '  ' $'\033[0;34m'Preparing app module...$'\033[0m'
appFile='src/app/app.module.ts'
echo '    ' $'\033[1;30m'App module:$'\033[0m' $appFile

# inject declaration template
declarationLine="import { ChildNameModule } from '\.\/modules\/child-name\/child-name\.module';"
sed -i -e "s/\(^.*\)\(\/app-routing.module\)\(.*$\)/\1\2\3\n$declarationLine/g" $appFile
echo '    ' $'\033[1;30m'Declaration template injected.$'\033[0m'

# inject import template
importLine="ChildNameModule,"
sed -i -e "s/\(^ *\)AppRoutingModule\(.*$\)/\1AppRoutingModule\2,\n\1$importLine/g" $appFile
echo '    ' $'\033[1;30m'Import template injected.$'\033[0m'

# generate modules
for i in "${!modules[@]}"
do
  echo '  ' $'\033[0;34m'Generating ${modulesParent[$i]}$'\033[0m' ${modules[$i]} $'\033[0;34m'module \($((i+1)) of ${#modules[@]}\):$'\033[0m'
  if [ -z ${modulesParent[$i]} ]; then
    moduleParameter=/app
  else
    moduleParameter=modules/${modulesParent[$i]}
  fi

  ng generate module modules/${modules[$i]} \
    --defaults=true \
    --dryRun=false \
    --force=true \
    --help=false \
    --interactive=false \
    \
    --flat=false \
    --lintFix=true \
    --module=$moduleParameter \
    --route=${modules[$i]} \
    --routing=true \
    --routingScope=Child \
    \
    1> /dev/null
    # --project=project \

  echo '    ' $'\033[0;35m'Registering ${modules[$i]} module with ${modulesParent[$i]} parent...$'\033[0m'

  if [ -z ${modulesParent[$i]} ]; then
    parentFile=$appFile
    parentComponentFile=/dev/null
  else
    # dasherize parent
    moduleParentDasherized=$(echo "${modulesParent[$i]}" \
      | sed 's/\(.\)\([A-Z]\)/\1-\2/g' \
      | tr '[:upper:]' '[:lower:]')
    # echo '    ' $moduleParentDasherized
    parentFile='src/app/modules/'$moduleParentDasherized/$moduleParentDasherized'.module.ts'
    parentComponentFile='src/app/modules/'$moduleParentDasherized/$moduleParentDasherized'.component.html'
  fi
  echo '      ' $'\033[1;30m'Parent:$'\033[0m' $parentFile

  # classify
  moduleClassified=$(echo "${modules[$i]}" \
    | sed 's/-\([a-z]\)/\U\1/g;s/^\([a-z]\)/\U\1/g')
  # echo '      ' $moduleClassified
  
  # dasherize
  moduleDasherized=$(echo "${modules[$i]}" \
    | sed 's/\(.\)\([A-Z]\)/\1-\2/g' \
    | tr '[:upper:]' '[:lower:]')
  # echo '      ' $moduleDasherized
    
  # guarding against duplicate modifications
  echo '      ' $'\033[1;30m'Sensing previous "^import.*$moduleClassified""Module *}" modification.$'\033[0m'
  if ! grep -q "^import.*$moduleClassified""Module *}" $parentFile
  then
    echo '      ' $'\033[1;30m'Proceeding with modifications...$'\033[0m'

    # duplicate child module template lines
    sed -i -e "s/\(^.*\)ChildName\(.*$\)/\1TokenName\2\n\1ChildName\2/g" $parentFile
    echo '      ' $'\033[1;30m'Child module declaration template line duplicated.$'\033[0m'
    
    # tokenize child module declaration template lines
    sed -i -e "s/\(^.*\)TokenName\(.*\)child-name\/child-name\(.*$\)/\1TokenName\2token-name\/token-name\3/g" $parentFile
    echo '      ' $'\033[1;30m'Child module declaration template line tokenized.$'\033[0m'
    
    # substitute import
    sed -i -e "s/TokenName/$moduleClassified/g" $parentFile
    echo '      ' $'\033[1;30m'Import substituted.$'\033[0m'

    # substitute declaration
    sed -i -e "s/token-name/$moduleDasherized/g" $parentFile
    echo '      ' $'\033[1;30m'Declaration substituted.$'\033[0m'
  fi  

  echo '      ' $'\033[1;30m'Registering component with$'\033[0m' ${parentComponentFile} $'\033[1;30m'parent...$'\033[0m'
  echo -e "\n<p>\n  <a href=\"/"${moduleDasherized}"\">"${moduleDasherized}"</a>\n  <app-"${moduleDasherized}"></app-"${moduleDasherized}">\n</p>" >> $parentComponentFile
done
echo '  ' $'\033[0;34m'Finalizing ${#modules[@]} modules:$'\033[0m'
for i in "${!modules[@]}"
do
  # dasherize
  moduleDasherized=$(echo "${modules[$i]}" \
    | sed 's/\(.\)\([A-Z]\)/\1-\2/g' \
    | tr '[:upper:]' '[:lower:]')
  # echo '    ' $moduleDasherized
  moduleFile='src/app/modules/'$moduleDasherized/$moduleDasherized'.module.ts'
  echo '    ' $'\033[0;35m'Finalizing module$'\033[0m' $moduleFile$'\033[0;35m'...$'\033[0m'

  file=$moduleFile
  # remove import
  sed -i -e "s/,,$/,/g" $file
  sed -i -e "/^ *$importLine/d" $file
  echo '      ' $'\033[1;30m'Import template removed.$'\033[0m'
  # remove declaration template
  sed -i -e "/ChildNameModule/d" $file
  echo '      ' $'\033[1;30m'Declaration template removed.$'\033[0m'
done
# finalizing app module
echo '  ' $'\033[0;34m'Finalizing app module:$'\033[0m'
echo '    ' $'\033[0;35m'Finalizing module$'\033[0m' $appFile$'\033[0;35m'...$'\033[0m'

file=$appFile
# remove import
sed -i -e "s/,,$/,/g" $file
sed -i -e "/^ *$importLine/d" $file
echo '      ' $'\033[1;30m'Import template removed.$'\033[0m'
# remove declaration template
sed -i -e "/ChildNameModule/d" $file
echo '      ' $'\033[1;30m'Declaration template removed.$'\033[0m'
echo

echo $'\033[0;32m'Generating ${#pipes[@]} pipes:$'\033[0m'
for i in "${!pipes[@]}"
do
  echo '  ' $'\033[0;34m'Generating$'\033[0m' ${pipes[$i]} $'\033[0;34m' pipe \($((i+1)) of ${#pipes[@]}\):$'\033[0m'
  ng generate pipe pipes/${pipes[$i]}/${pipes[$i]} \
    --defaults=true \
    --dryRun=false \
    --force=true \
    --help=false \
    --interactive=false \
    \
    --lintFix=true \
    \
    1> /dev/null
    # --prefix=prefix \
    # --project=project \
done
echo

echo $'\033[0;32m'Generating ${#services[@]} services:$'\033[0m'
for i in "${!services[@]}"
do
  echo '  ' $'\033[0;34m'Generating$'\033[0m' ${services[$i]} $'\033[0;34m'service \($((i+1)) of ${#services[@]}\):$'\033[0m'
  ng generate service services/${services[$i]}/${services[$i]} \
    --defaults=true \
    --dryRun=false \
    --force=true \
    --help=false \
    --interactive=false \
    \
    --lintFix=true \
    \
    1> /dev/null
    # --prefix=prefix \
    # --project=project \
done
echo


echo $'\033[1;30m'Restoring directory...$'\033[0m'
cd $pwd
pwd
ls -F --color=always
echo

SCAFFOLD_GENERATE_TASK_PID=$!
echo $'\033[0;33m'Scaffolder generate finished...$'\033[0m'

echo
# read  -n 1 -p "x" input
# exit