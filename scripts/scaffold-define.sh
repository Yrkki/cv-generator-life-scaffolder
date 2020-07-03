#!/bin/bash

echo $'\033[1;33m'Running script scaffold-generate-parameters
echo ------------------------------------------------------
echo

echo Scaffolder generate setting parameters starting...$'\033[0m'
pwd=$(pwd)
pwd
ls -F --color=always
echo


cvgRoot=$1
# echo cvgRoot= $cvgRoot

pwd=$(pwd)

appName='cv-generator-fe'
generateApp=false
serve=false
open=false
build=false
test=false
lint=false
e2e=false

classes=('cv' 'entities' 'gantt-chart-entry' 'general-timeline-entry' 'project' 'ui')
components=()
guards=()
interfaces=( \
  'cv/cv' 'cv/personal-data' 'cv/professional-experience' 'cv/education' 'cv/certification' 'cv/language' 'cv/course' 'cv/publication' \
  'entities/entities' 'entities/entity' \
  'gantt-chart-entry/gantt-chart-entry'  \
  'general-timeline-entry/general-timeline-entry' \
  'project/project'  \
  'ui/ui' 'ui/ui-entry' \
  )
modules=('portfolio' 'webpage' 'navigation' 'search' 'cv' 'project-summary' 'project' 'general-timeline' 'footer' 'property' 'soc-bar' 'personal-data' 'background' 'accomplishments' 'education' 'professional-experience' 'language' 'course' 'general-timeline-map' 'publication' 'project-gantt-chart-map' 'project-contributions' 'course-index' 'course-list' 'publication-index' 'publication-list' 'spectrum' 'map' 'project-gantt-chart' 'project-list' 'project-index' 'project-card')
modulesParent=('' '' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'webpage' 'cv' 'cv' 'cv' 'background' 'background' 'accomplishments' 'accomplishments' 'accomplishments' 'accomplishments' 'accomplishments' 'accomplishments' 'course' 'course' 'publication' 'publication' 'project-summary' 'project-summary' 'project' 'project' 'project' 'project')
pipes=('keys')
services=('chart' 'check-for-update' 'component-outlet-injector' 'data' 'excel-date-formatter' 'gantt-chart' 'general-timeline' 'is-secure-guard' 'log-update' 'mock-data' 'prompt-update' 'search-engine' 'search-tokenizer' 'string-ex' 'tag-cloud-processor' 'theme-changer')

# # testing overrides
# appName='cv-generator-fe2-fix1'
# generateApp=false
# serve=true
# open=true
# build=false
# test=false
# lint=false
# e2e=false

# classes=()
# components=()
# guards=()
# interfaces=()
# modules=('aaa' 'aaaa-comp' 'aaab-comp' 'aaaaa-comp')
# modulesParent=('' 'aaa' 'aaa' 'aaaa-comp')
# modules=('aaa' 'aaaa-comp')
# modulesParent=('' 'aaa')
# modules=('master' 'slave')
# modulesParent=('' 'master')
# modules=('portfolio' 'webpage' 'navigation' 'search' 'cv' 'project-summary' 'project' 'general-timeline' 'footer' 'property' 'soc-bar')
# modulesParent=('' '' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'webpage')
# modules=('portfolio' 'webpage')
# modulesParent=('' '')
# modules=('portfolio' 'webpage' 'navigation')
# modulesParent=('' '' 'portfolio')
# modules=('portfolio' 'webpage' 'navigation' 'search' 'cv' 'project-summary' 'project' 'general-timeline' 'footer')
# modulesParent=('' '' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio')
# pipes=()
# services=()

# testing overrides
appName='cv-generator-fe2-fix1'
generateApp=false
serve=true
open=true
build=true
test=true
lint=true
e2e=true

classes=()
components=()
guards=()
interfaces=()
modules=('portfolio' 'webpage' 'navigation' 'search' 'cv' 'project-summary' 'project' 'general-timeline' 'footer' 'property' 'soc-bar' 'personal-data' 'background' 'accomplishments' 'education' 'professional-experience' 'language' 'course' 'general-timeline-map' 'publication' 'project-gantt-chart-map' 'project-contributions' 'course-index' 'course-list' 'publication-index' 'publication-list' 'spectrum' 'map' 'project-gantt-chart' 'project-list' 'project-index' 'project-card')
modulesParent=('' '' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'webpage' 'cv' 'cv' 'cv' 'background' 'background' 'accomplishments' 'accomplishments' 'accomplishments' 'accomplishments' 'accomplishments' 'accomplishments' 'course' 'course' 'publication' 'publication' 'project-summary' 'project-summary' 'project' 'project' 'project' 'project')
modules=('portfolio' 'webpage' 'navigation' 'search' 'cv' 'project-summary' 'project' 'general-timeline' 'footer' 'property' 'soc-bar')
modulesParent=('' '' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'webpage')
# modules=('portfolio' 'webpage' 'navigation' 'search' 'cv' 'project-summary' 'project' 'general-timeline' 'footer' 'property')
# modulesParent=('' '' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio')
# modules=('portfolio' 'webpage' 'navigation' 'search' 'cv' 'project-summary' 'project')
# modulesParent=('' '' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio')
# modules=('portfolio' 'webpage' 'navigation' 'search' 'cv' 'project-summary')
# modulesParent=('' '' 'portfolio' 'portfolio' 'portfolio' 'portfolio')
# modules=('portfolio' 'webpage' 'navigation')
# modulesParent=('' '' 'portfolio')
# modules=('webpage' 'soc-bar')
# modulesParent=('' 'webpage')
modules=('portfolio' 'webpage' 'navigation' 'search' 'cv' 'project-summary' 'project' 'general-timeline' 'footer' 'property' 'personal-data')
modulesParent=('' '' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'portfolio' 'cv')
modules=('portfolio' 'webpage' 'navigation' 'search' 'cv' 'personal-data')
modulesParent=('' '' 'portfolio' 'portfolio' 'portfolio' 'cv')
modules=('portfolio' 'cv' 'personal-data')
modulesParent=(''  'portfolio' 'cv')
modules=('portfolio' 'cv' 'accomplishments' 'course' 'course-index')
modulesParent=('' 'portfolio' 'cv' 'accomplishments' 'course')
pipes=()
services=()

echo $'\033[0;32m'Parameters set:$'\033[0m'
echo '  ' $'\033[1;30m'Application name:$'\033[0m' $appName
echo '  ' $'\033[1;30m'Generate app?:$'\033[0m' $generateApp
echo '  ' $'\033[1;30m'Classes:$'\033[0m' ${#classes[@]}: "${classes[*]}"
echo '  ' $'\033[1;30m'Components:$'\033[0m' "${#components[@]}": "${components[*]}"
echo '  ' $'\033[1;30m'Guards:$'\033[0m' "${#guards[@]}": "${guards[*]}"
echo '  ' $'\033[1;30m'Interfaces:$'\033[0m' "${#interfaces[@]}": "${interfaces[*]}"
echo '  ' $'\033[1;30m'Modules:$'\033[0m' "${#modules[@]}": "${modules[*]}"
echo '  ' $'\033[1;30m'  Modules parents:$'\033[0m' $'\033[0;37m'"${#modulesParent[@]}": "${modulesParent[*]}"$'\033[0m'
echo '  ' $'\033[1;30m'Pipes:$'\033[0m' "${#pipes[@]}": "${pipes[*]}"
echo '  ' $'\033[1;30m'Services:$'\033[0m' "${#services[@]}": "${services[*]}"
echo

echo $'\033[1;30m'Restoring directory...$'\033[0m'
cd $pwd
pwd
ls -F --color=always
echo

SCAFFOLD_GENERATE_TASK_PID=$!
echo $'\033[0;33m'Scaffolder generate setting parameters finished...$'\033[0m'

echo
# read  -n 1 -p "x" input
# exit