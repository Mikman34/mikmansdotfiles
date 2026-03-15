#!/bin/bash
git add .
git commit -m "update dotfiles $(date '+%Y-%m-%d %H:%M')"
git push origin main
