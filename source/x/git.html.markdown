---
title: Git
---

<h1>Git</h1>

~~~bash
# stage everything including deleted files
git add -A .
git commit -m "my msg"


# delete all merged remote branches
git branch -r --merged | egrep -v "(^\*|main|master|dev|stable)" | sed 's/origin\///' | xargs -n 1 git push --delete origin

# from Chris Ngyen, I think this one deletes local and remote merged branches
git branch --merged | egrep -v "(^\*|main|master|dev|stable)" | xargs git branch -d
~~~

## Git bisect

~~~bash
git bisect start
git bisect good # marks current commit as good
git bisect bad 33f3849b # marks the commit you know to be bad
# then, git takes over from there... you just mark each as good or bad
git bisect good # marks current commit as good

# or run it automatically:
git bisect run yarn jest
# with multiple commands:
git bisect run sh -c 'yarn --ignore-engines && yarn jest'

# at the end:
git bisect reset
~~~
