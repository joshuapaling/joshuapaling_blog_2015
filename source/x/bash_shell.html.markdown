---
title: Bash / Shell
---

<h1>Bash / Shell</h1>

~~~bash
$? # result of last run cmd
$! # process ID of the most recently executed background (asynchronous) command.

~~~

~~~bash
# upgrade packages if tests pass
declare -a packages=(
  "bootstrap-sass"
  "browser-sync"
  "currency-formatter"
  "watchify"
)

for i in "${packages[@]}"
do
  yarn upgrade $i --latest --tilde
  yarn install --ignore-engines && yarn test
  if [ "$?" = 0 ]; then
    echo "############## YES UPGRADING $i #############"
    git add .
    git commit -m "yarn upgrade $i --latest --tilde"
  else
    echo "############## NOT UPGRADING $i #############"
    git reset --hard
  fi
done
~~~
