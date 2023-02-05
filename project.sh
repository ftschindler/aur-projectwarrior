#!/bin/bash

if ! [[ -e ~/.projects ]] ; then
  echo "+-----------------------------------------------------+"
  echo "|                                                     |"
  echo "| projectwarrior stores everything in ~/.projects     |"
  echo "| performing:                                         |"
  echo "|   mkdir -p ~/.projects                              |"
  echo "|   touch ~/.projects/projects.txt                    |"
  echo "|   touch ~/.projects/{active,completed,deleted}.json |"
  echo "|                                                     |"
  echo "+-----------------------------------------------------+"

  mkdir -p ~/.local/share/projectwarrior/.projects
  ln -s ~/.local/share/projectwarrior/.projects ~/.projects
  touch ~/.projects/projects.txt
  touch ~/.projects/{active,completed,deleted}.json
fi

cd ~/.local/share/projectwarrior && ./projectwarrior $@

