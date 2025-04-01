#!/bin/bash
# takes a screenshot based on our selection and adds it to clipboard
flameshot gui --raw | convert -resize 400% png:- png:- | tesseract -l eng stdin stdout | xclip -selection clipboard
