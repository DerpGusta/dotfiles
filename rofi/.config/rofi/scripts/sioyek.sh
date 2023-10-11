#!/usr/bin/env bash
SEARCH_ROOT=$HOME
BOOK=$(fd -t f -e pdf -e epub '' "$SEARCH_ROOT" | rofi -no-auto-select -dmenu -sorting-method fzf -i -p " " -keep-right)

if [ -n "$BOOK" ]
then
      sioyek "$BOOK";
      exit 0;
else
  exit 1
fi
