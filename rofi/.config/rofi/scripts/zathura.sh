#!/usr/bin/env bash
SEARCH_ROOT=$HOME
BOOK=$(fd -t f -e pdf -e epub '' "$SEARCH_ROOT" | rofi -no-auto-select -dmenu -sorting-method fzf -i -p " " -keep-right)

if [ -n "$BOOK" ]
then
  if [ -n "$1" ]
  then
    if [ "$1" = "dark" ]
    then
      zathura --config-dir="~/.config/zathura-dark" "$BOOK";
      exit 0;
    else
      zathura "$BOOK";
      echo "$BOOK"
      exit 0;
    fi
  fi	
else
  exit 0
fi
