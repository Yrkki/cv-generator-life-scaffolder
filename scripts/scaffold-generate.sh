#!/bin/bash

echo $'\033[1;32m'Running script scaffold-generate
echo ------------------------------------------------------
echo

echo Scaffolder generate starting...$'\033[0m'
pwd=$(pwd)
pwd
ls -aF --color=always
echo


function processTemplate {
  targetFile=$1
  echo '  ' $'\033[1;30m'Processing the $'\033[0m' $targetFile $'\033[1;30m'template...$'\033[0m'

  echo -n '    ' $'\033[1;30m'':'
  joinRegEx="s/-//g"
  splitRegEx="s/-/ /g"
  snakeRegEx="s/-/_/g"
  camelizeRegEx="s/-(.)/ \U\1/g"
  plusRegEx="s/\b(Cv|Icb|Id|Tv)\b/\U\1/gI"

  echo -n ' dasherize'
  dasherize=$(echo ${appName,,})
  sed -i -e "s/<%= utils.dasherize(name) %>/$dasherize/g" $targetFile

  echo -n ' favicon'
  favicon=" --customFavicon \\\\\\\".\/src\/favicon\/android-chrome-512x512.png\\\\\\\""
  sed -i -e "s/<%= utils.favicon(name) %>/$favicon/g" $targetFile

  echo -n ' join'
  join=$(echo ${dasherize} | sed -r "${joinRegEx}")
  sed -i -e "s/<%= utils.join(name) %>/$join/g" $targetFile

  echo -n ' spacify'
  spacify=$(echo ${appName^} | sed -r "${splitRegEx}")
  sed -i -e "s/<%= utils.spacify(name) %>/$spacify/g" $targetFile
  echo -n ' spacifyPlus'
  spacifyPlus=$(echo ${spacify} | sed -r "${plusRegEx}")
  sed -i -e "s/<%= utils.spacifyPlus(name) %>/$spacifyPlus/g" $targetFile

  echo -n ' titlecase'
  titlecase=$(echo ${appName^} | sed -r "${camelizeRegEx}")
  sed -i -e "s/<%= utils.titlecase(name) %>/$titlecase/g" $targetFile
  echo -n ' titlecasePlus'
  titlecasePlus=$(echo ${titlecase} | sed -r "${plusRegEx}")
  sed -i -e "s/<%= utils.titlecasePlus(name) %>/$titlecasePlus/g" $targetFile

  echo -n ' classify'
  classify=$(echo ${titlecase} | sed -r "${joinRegEx}")
  sed -i -e "s/<%= utils.classify(name) %>/$classify/g" $targetFile

  echo -n ' uppersnakecase'
  uppersnakecase=$(echo ${appName^^} | sed -r "${snakeRegEx}")
  sed -i -e "s/<%= utils.uppersnakecase(name) %>/$uppersnakecase/g" $targetFile

  echo $'\033[1;30m'' (done)'$'\033[0m'
}

function processAllTemplates {
  templatePath=$1
  processTemplate $templatePath'/workspace/files/package.json.template'
  processTemplate $templatePath'/workspace/files/README.md.template'
  for i in $(find $templatePath/application/files -maxdepth 2 -type f); do
    processTemplate $i
  done
  for i in $(find $templatePath/application/files/src/environments -maxdepth 1 -type f); do
    processTemplate $i
  done
}

cvgRoot=$1
# echo cvgRoot= $cvgRoot

. ./scaffold-define.sh $cvgRoot


echo $'\033[0;32m'Redirecting output...$'\033[0m'
# Create an out_fd variable that points to stdout (FD 1) if dexflag != "false", or to a new
# handle on /dev/null otherwise
if [ $verbose == true ]; then
  echo '  ' $'\033[1;30m'Redirecting output to device: 1 $'\033[0m'
  out_fd=1 # use FD 1 (stdout)
  # exec {out_fd}>&1 # use FD 1 (stdout)
else
  echo '  ' $'\033[1;30m'Redirecting output to device: /dev/null $'\033[0m'
  exec {out_fd}>/dev/null # maybe put 2>&1 as well to suppress stderr
fi

# Close file when needed. To be done at the end of processing...
# # if out_fd is not stdin/stdout/stderr, then go ahead and close it when done.
# (( out_fd > 2 )) && exec {out_fd}>&-
echo '    ' $'\033[1;30m'Output redirected to device: "$out_fd" $'\033[0m'
echo


# Preparing the ng generate global and local commands paths
modSchematicsPath='@schematics/'
modNodeModulesPath='node_modules/'
modAngularPath='angular/'
modAngularCliPath='C:\Users\'"$USERNAME"'\AppData\Roaming\npm\node_modules\@angular\cli\'
modNodeModulesSchematicsPath="$modNodeModulesPath""$modSchematicsPath"
modNodeModulesSchematicsAngularPath="$modNodeModulesPath""$modSchematicsPath""$modAngularPath"
modSchematicsAngularPath="$modSchematicsPath""$modAngularPath"
modTemplateAngularPath=$(realpath "$modSchematicsAngularPath")
modGlobalPath=$(realpath "$modAngularCliPath""$modNodeModulesSchematicsPath")
modGlobalAngularPath=$(realpath "$modAngularCliPath""$modNodeModulesSchematicsAngularPath")
modTemplatePath="$modNodeModulesSchematicsPath"

if [ $modGlobalSchematics == true ]; then
  echo $'\033[0;32m'Modding the ng generate global commands...$'\033[0m'
  echo '  ' $'\033[1;30m'Copying template schematics from $'\033[0m' $modTemplateAngularPath
  echo '    ' $'\033[1;30m'to global $'\033[0m' $modGlobalPath $'\033[1;30m'...$'\033[0m'
  cp -r $modTemplateAngularPath $modGlobalPath
  processAllTemplates $modGlobalAngularPath
  echo '  ' $'\033[1;30m'Ng generate global commands modded.$'\033[0m'
  echo
fi


echo $'\033[0;32m'Switching to root directory:$'\033[0m'
cd $cvgRoot
pwd
ls -aF --color=always
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
    --verbose=$verbose \
    \
    1>&"$out_fd"
fi
echo

echo $'\033[0;32m'Switching to application directory:$'\033[0m'
mkdir -p $appName
cd $appName
pwd
ls -aF --color=always
echo

if [ $modLocalSchematics == true ]; then
  echo $'\033[0;32m'Modding the ng generate commands...$'\033[0m'
  echo '  ' $'\033[1;30m'Copying global schematics from $'\033[0m' $modGlobalAngularPath
  echo '    ' $'\033[1;30m'to local $'\033[0m' $modTemplatePath $'\033[1;30m'...$'\033[0m'
  cp -r $modGlobalAngularPath $modTemplatePath
  echo '  ' $'\033[1;30m'Ng generate commands modded.$'\033[0m'
  echo
fi

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
    1>&"$out_fd"
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
    1>&"$out_fd"
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
    1>&"$out_fd"
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
    1>&"$out_fd"
    # --interface \
    # --project=project \
done
echo

echo $'\033[0;32m'Generating ${#interfaces[@]} interfaces:$'\033[0m'
for i in "${!interfaces[@]}"
do
  echo '  ' $'\033[0;34m'Generating$'\033[0m' ${interfaces[$i]} $'\033[0;34m' interface \($((i+1)) of ${#interfaces[@]}\):$'\033[0m'
  if [ ! ${interfaces[$i]}=="*\/*" ] ; then interface=${interfaces[$i]}/${interfaces[$i]} ; else interface=${interfaces[$i]}; fi
  echo '    ' $'\033[0;35m'Using the$'\033[0m' $interface $'\033[0;35m' name.$'\033[0m'
  ng generate interface interfaces/$interface \
    --defaults=true \
    --dryRun=false \
    --force=true \
    --help=false \
    --interactive=false \
    \
    --lintFix=false \
    \
    1>&"$out_fd"
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
  if [[ ${modulesParent[$i]} =~ ^(ROOT|)$ ]]; then
    echo '    ' $'\033[1;30m'Parent is root$'\033[0m'
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
    1>&"$out_fd"
    # --project=project \

  echo '    ' $'\033[0;35m'Registering ${modules[$i]} module with ${modulesParent[$i]} parent...$'\033[0m'

  if [[ ${modulesParent[$i]} =~ ^(ROOT|)$ ]]; then
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
    1>&"$out_fd"
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
    1>&"$out_fd"
    # --prefix=prefix \
    # --project=project \
done
echo


echo $'\033[1;30m'Restoring directory...$'\033[0m'
cd $pwd
pwd
ls -aF --color=always
echo

SCAFFOLD_GENERATE_TASK_PID=$!
echo $'\033[0;32m'Scaffolder generate finished...$'\033[0m'

echo
# read  -n 1 -p "x" input
# exit