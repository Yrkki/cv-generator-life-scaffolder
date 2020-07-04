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

ngGenrateModPath='\@schematics/'
ngGenrateMod=$(realpath './'$ngGenrateModPath'angular/')

echo $'\033[0;32m'Modding the ng generate global commands...$'\033[0m'
cp -r $ngGenrateMod 'C:\Users\Jorich\AppData\Roaming\npm\node_modules\@angular\cli\node_modules\@schematics/'
echo '  ' $'\033[1;30m'Ng generate global commands modded.$'\033[0m'
echo


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
cp -r $ngGenrateMod './node_modules/'$ngGenrateModPath
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
    --lintFix=false \
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
  ng generate component components/${components[$i]} \
    --defaults=true \
    --dryRun=false \
    --force=true \
    --help=false \
    --interactive=false \
    \
    --lintFix=false \
    \
    1> /dev/null
    # --changeDetection=Default \
    # --displayBlock=false \
    # --entryComponent=false \
    # --export=false \
    # --flat=false \
    # --inlineStyle=false \
    # --inlineTemplate=false \
    # --module=module \
    # --prefix=prefix \
    # --project=project \
    # --selector=selector \
    # --skipImport=false \
    # --skipSelector=false \
    # --skipTests=false \
    # --style=scss \
    # --type='routing' \
    # --viewEncapsulation=Emulated \
done
echo

echo $'\033[0;32m'Generating ${#enums[@]} enums:$'\033[0m'
for i in "${!enums[@]}"
do
  echo '  ' $'\033[0;34m'Generating$'\033[0m' ${enums[$i]} $'\033[0;34m'enum \($((i+1)) of ${#enums[@]}\):$'\033[0m'
  ng generate enum enums/${enums[$i]} \
    --defaults=true \
    --dryRun=false \
    --force=true \
    --help=false \
    --interactive=false \
    \
    --lintFix=false \
    \
    1> /dev/null
    # --project=project \
done
echo

echo $'\033[0;32m'Generating ${#guards[@]} guards:$'\033[0m'
for i in "${!guards[@]}"
do
  echo '  ' $'\033[0;34m'Generating$'\033[0m' ${guards[$i]} $'\033[0;34m'guard \($((i+1)) of ${#guards[@]}\):$'\033[0m'
  ng generate guard guards/${guards[$i]} \
    --defaults=true \
    --dryRun=false \
    --force=true \
    --help=false \
    --interactive=false \
    \
    --flat=false \
    --lintFix=false \
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
    --lintFix=false \
    \
    1> /dev/null
    # --prefix=prefix \
    # --project=project \

  echo '    ' $'\033[0;35m'Registering ${interfaces[$i]} interface with parent class:$'\033[0m'
  echo '      ' $'\033[1;30m'TODO...$'\033[0m'
done
echo

echo $'\033[0;32m'Generating ${#modules[@]} modules:$'\033[0m'

# Declarations
appFile='src/app/app.module.ts'
declarationLine="import { ChildNameModule } from '\.\/modules\/child-name\/child-name\.module';"
importLine="ChildNameModule,"

# ### This runtime injection section is currently swapped with ahead-of-time declarations in the templates

# echo '  ' $'\033[0;34m'Preparing app module...$'\033[0m'
# echo '    ' $'\033[1;30m'App module:$'\033[0m' $appFile

# # inject declaration template
# sed -i -e "s/\(^.*\)\(\/app-routing.module\)\(.*$\)/\1\2\3\n$declarationLine/g" $appFile
# echo '    ' $'\033[1;30m'Declaration template injected.$'\033[0m'

# # inject import template
# sed -i -e "s/\(^ *\)AppRoutingModule\(.*$\)/\1AppRoutingModule\2,\n\1$importLine/g" $appFile
# echo '    ' $'\033[1;30m'Import template injected.$'\033[0m'

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
    --lintFix=false \
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

  echo -n '      ' $'\033[1;30m'Registering component with$'\033[0m' $parentComponentFile $'\033[1;30m'parent...$'\033[0m'
  echo -e "\n<p>\n  <a href=\"/$moduleDasherized\">$moduleDasherized</a>\n  <app-$moduleDasherized></app-$moduleDasherized>\n</p>" >> $parentComponentFile
  echo $'\033[1;30m'' (done)'$'\033[0m'

  echo -n '      ' $'\033[1;30m'Registering component with end-to-end tests...$'\033[0m'
  e2eTestFile='e2e\src\app.e2e-spec.ts'
  e2eTestPlaceholder='\/\/ \[% e2e-test-placeholder %\]'
  e2eTestContentDetection=$(echo -n -e "it('should be able to navigate to the $moduleClassified module'")
  e2eTestContent=$(echo -n -e "$e2eTestContentDetection, () => {\\
    expect(() => page.navigateToModule('$moduleDasherized')).not.toThrowError();\\
  });\\
\\
  "$e2eTestPlaceholder | tr '\n' 'n')
  if ! grep -q "$e2eTestContentDetection" $e2eTestFile
  then
    sed -i -e "s/$e2eTestPlaceholder/$e2eTestContent/g" $e2eTestFile
  fi
  echo $'\033[1;30m'' (done)'$'\033[0m'
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
    --lintFix=false \
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
    --lintFix=false \
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