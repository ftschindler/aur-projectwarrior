#!/bin/bash

if ! [[ -e ~/.projects ]] ; then
  echo "+-----------------------------------------------------+"
  echo "|                                                     |"
  echo "| projectwarrior stores everything in ~/.projects     |"
  echo "| creating:                                           |"
  echo "|   mkdir -p ~/.projects                              |"
  echo "|   touch ~/.projects/projects.txt                    |"
  echo "|   touch ~/.projects/{active,completed,deleted}.json |"
  echo "|                                                     |"
  echo "+-----------------------------------------------------+"

  mkdir -p ~/.projects
  touch ~/.projects/projects.txt
  touch ~/.projects/{active,completed,deleted}.json
fi

cd /usr/share/projectwarrior/src && ./projectwarrior $@

