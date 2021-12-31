#!/bin/bash
path=$(pwd)
rm -rf developerEmail.txt
while read gitLink
  do

    echo "Start cloning Project $gitLink" 
    git clone $gitLink

    #get app name
    arr=(`echo $gitLink| tr '/' ' '`)
    appPath="${path}/${arr[3]}"
    cd $appPath

    git log > ../${arr[3]}_log.txt
    rm -rf $appPath

    cd path

    while read line
        do 
            if [[ "$line" = "Author: "* ]]; then
                if [[ $(grep "$line" "developerEmail.txt") ]]; then
                    echo "Already sevad not save agein"
                else
                    echo $line >> developerEmail.txt
                    echo "Save developer email:${line}"
                fi
            fi
    done < ${arr[3]}_log.txt
    rm -rf ${arr[3]}_log.txt

done < git.links.txt