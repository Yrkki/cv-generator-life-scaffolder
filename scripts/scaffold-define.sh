#!/bin/bash

echo $'\033[1;32m'Running script scaffold-define
echo ------------------------------------------------------
echo

echo Scaffolder define starting...$'\033[0m'
pwd=$(pwd)
pwd
ls -aF --color=always
echo


cvgRoot=$1
# echo cvgRoot= $cvgRoot

pwd=$(pwd)

appName='cv-generator-fe'
generateApp=false
verbose=false
allowRoutingComponent=false
keepComponentFiles=true
modGlobalSchematics=true
modLocalSchematics=true
startPipeline=false
serve=false
open=false
build=false
test=false
lint=false
e2e=false
doc=false

classes=('cv' 'entities' 'gantt-chart-entry' 'general-timeline-entry' 'project' 'ui')
components=()
enums=()
guards=()
interfaces=( \
  'cv/cv' 'cv/personal-data' 'cv/professional-experience' 'cv/education' 'cv/certification' 'cv/language' 'cv/course' 'cv/publication' \
  'entities/entities' 'entities/entity' \
  'gantt-chart-entry/gantt-chart-entry' \
  'general-timeline-entry/general-timeline-entry' \
  'project/project' \
  'ui/ui' 'ui/ui-entry' \
  )
# modules=('portfolio' 'webpage' 'navigation' 'search' 'cv' 'project-gantt-chart-map' 'project-summary' 'project' 'general-timeline' 'footer' 'property' 'soc-bar' 'personal-data' 'background' 'accomplishments' 'education' 'professional-experience' 'language' 'course' 'general-timeline-map' 'publication' 'project-gantt-chart-map' 'project-contributions' 'course-index' 'course-list' 'publication-index' 'publication-list' 'spectrum' 'map' 'project-gantt-chart' 'project-contributions' 'project-list' 'project-index' 'project-card')
# modulesParent=('ROOT' 'ROOT' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'webpage' 'cv' 'cv' 'cv' 'background' 'background' 'accomplishments' 'accomplishments' 'accomplishments' 'accomplishments' 'accomplishments' 'accomplishments' 'course' 'course' 'publication' 'publication' 'project-summary' 'project-summary' 'project' 'project' 'project' 'project' 'project')
modules=()
modulesParent=()
routes=( \
  '/portfolio' '/webpage' \
  'portfolio/navigation' 'portfolio/search' 'portfolio/cv' 'portfolio/project-gantt-chart-map' 'portfolio/project-summary' 'portfolio/project' 'portfolio/general-timeline' 'portfolio/footer' 'portfolio/property' \
  'webpage/soc-bar' \
  'cv/personal-data' 'cv/background' 'cv/accomplishments' \
  'background/education' 'background/professional-experience' \
  'accomplishments/language' 'accomplishments/course' 'accomplishments/general-timeline-map' 'accomplishments/publication' 'accomplishments/project-gantt-chart-map' 'accomplishments/project-contributions' \
  'course/course-index' 'course/course-list' \
  'publication/publication-index' 'publication/publication-list' \
  'project-summary/spectrum' 'project-summary/map' 'project/project-gantt-chart' 'project/project-contributions' 'project/project-list' 'project/project-index' 'project/project-card')
pipes=('keys')
services=('chart' 'check-for-update' 'component-outlet-injector' 'data' 'excel-date-formatter' 'gantt-chart' 'general-timeline' 'is-secure-guard' 'log-update' 'mock-data' 'portfolio' 'prompt-update' 'search-engine' 'search-tokenizer' 'string-ex' 'tag-cloud-processor' 'theme-changer')


# # testing overrides
# -------------------

# classes=()
# components=()
# enums=()
# guards=()
# interfaces=()
# modules=()
# modulesParent=()
# modules=('aaa' 'aaaa-comp' 'aaab-comp' 'aaaaa-comp')
# modulesParent=('ROOT' 'aaa' 'aaa' 'aaaa-comp')
# modules=('aaa' 'aaaa-comp')
# modulesParent=('ROOT' 'aaa')
# modules=('master' 'slave')
# modulesParent=('ROOT' 'master')
# modules=('portfolio' 'webpage' 'navigation' 'search' 'cv' 'project-summary' 'project' 'general-timeline' 'footer' 'property' 'soc-bar')
# modulesParent=('ROOT' 'ROOT' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'webpage')
# modules=('portfolio' 'webpage')
# modulesParent=('ROOT' 'ROOT')
# modules=('portfolio' 'webpage' 'navigation')
# modulesParent=('ROOT' 'ROOT' 'portfolio')
# modules=('portfolio' 'webpage' 'navigation' 'search' 'cv' 'project-summary' 'project' 'general-timeline' 'footer')
# modulesParent=('ROOT' 'ROOT' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio')
# pipes=()
# services=()

classes=('test-class-one' 'test-class-two')
components=('test-component-one' 'test-component-two')
enums=('test-enum-one' 'test-enum-two')
guards=('test-guard-one' 'test-guard-two')
# interfaces=( \
#   'test-class-one/test-interface-one' \
#   'test-class-two/test-interface-two' \
#   'test-class-three/test-interface-three' \
#   'test-interface-four' \
#   'test-class-two/test-interface-five' \
#   'test-class-three/test-interface-five')
interfaces=( \
  'test-class-one/test-class-one' \
  'test-class-two/test-class-two' \
  'test-interface-one' \
  'test-interface-two' \
  'test-interface-three' \
  'test-interface-four' \
  'test-interface-five' \
  'test-interface-six/test-interface-six')
# implementations=( \
#   'test-class-one/test-interface-one' \
#   'test-class-two/test-interface-two' \
#   'test-class-two/test-interface-five' \
#   'test-class-three/test-interface-three' \
#   'test-class-three/test-interface-five')
modules=('portfolio' 'webpage' 'navigation' 'search' 'cv' 'project-summary' 'project' 'general-timeline' 'footer' 'property' 'soc-bar')
modulesParent=('ROOT' 'ROOT' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'webpage')
modules=('portfolio' 'webpage' 'navigation' 'search' 'cv' 'project-summary' 'project' 'general-timeline' 'footer' 'property')
modulesParent=('ROOT' 'ROOT' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio')
modules=('portfolio' 'webpage' 'navigation' 'search' 'cv' 'project-summary' 'project')
modulesParent=('ROOT' 'ROOT' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio')
modules=('portfolio' 'webpage' 'navigation' 'search' 'cv' 'project-summary')
modulesParent=('ROOT' 'ROOT' 'portfolio' 'portfolio' 'portfolio' 'portfolio')
modules=('portfolio' 'webpage' 'navigation')
modulesParent=('ROOT' 'ROOT' 'portfolio')
modules=('webpage' 'soc-bar')
modulesParent=('ROOT' 'webpage')
modules=('portfolio' 'cv')
modulesParent=('ROOT'  'portfolio')
modules=('test-one' 'test-two')
modulesParent=('ROOT' 'ROOT')
pipes=('test-pipes-one' 'test-pipes-two')
services=('test-service-one' 'test-service-two')
routes=()

appName='cv-generator-fe6'
generateApp=true
verbose=true
# allowRoutingComponent=false
keepComponentFiles=true
modGlobalSchematics=true
modLocalSchematics=true
startPipeline=false
# serve=true
open=false
# build=true
# test=true
# lint=true
# e2e=true
# doc=true

# appName='cv-generator-fe'
# generateApp=true
# verbose=false
# allowRoutingComponent=false
# keepComponentFiles=true
# modGlobalSchematics=true
# modLocalSchematics=true
# startPipeline=false
# serve=false
# open=false
# build=false
# test=false
# lint=false
# e2e=false
# doc=false

# classes=()
# components=()
# enums=()
# guards=()
# interfaces=()
# modules=()
# modulesParent=()
# routes=()
# pipes=()
# services=()

# # routes=( \
# #   '/portfolio' '/webpage' \
# #   'portfolio/navigation' 'portfolio/search' 'portfolio/project' \
# #   'cv/personal-data' 'cv/accomplishments' \
# #   'accomplishments/general-timeline-map' 'accomplishments/publication' 'accomplishments/project-gantt-chart-map' 'accomplishments/project-contributions' \
# #   'project/project-contributions' 'project/project-list')

# --------------------------
# # end of testing overrides

. ./scaffold-define-preprocess.sh $cvgRoot


echo $'\033[1;30m'Restoring directory...$'\033[0m'
cd $pwd
pwd
ls -aF --color=always
echo

SCAFFOLD_GENERATE_TASK_PID=$!
echo $'\033[0;32m'Scaffolder define finished...$'\033[0m'

echo
# read  -n 1 -p "x" input
# exit