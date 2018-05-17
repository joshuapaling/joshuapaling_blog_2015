---
title: Git
---

<h1>Git</h1>

~~~bash
# stage everything including deleted files
git add -A .
git commit -m "my msg"


# delete all merged remote branches
git branch -r --merged | grep -v master | sed 's/origin\///' | xargs -n 1 git push --delete origin
~~~

