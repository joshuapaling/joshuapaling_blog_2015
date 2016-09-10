#!/bin/bash
cd $(dirname "${0}")
git add -A .
git commit -m 'automated commit'
git push
bundle exec middleman build
bundle exec middleman deploy