#!/bin/bash
# this file is used to auto-generate .qm file from .ts file.
# author: shibowen at linuxdeepin.com

LRELEASE=/usr/lib/qt6/bin/lrelease

ts_list=(`ls translations/*.ts`)

for ts in "${ts_list[@]}"
do
    printf "\nprocess ${ts}\n"
    ${LRELEASE} "${ts}"
done
