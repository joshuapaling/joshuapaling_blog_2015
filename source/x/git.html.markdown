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

## print branches with last commit date

You can then use this to move the date to the front, sort, and delete old branches.
Unfortunately scripts [like this](https://praneethreddybilakanti.medium.com/how-to-delete-old-remote-git-branches-via-bash-script-712fab26a536#:~:text=Get%20the%20last%20commit%20date,git%20push%20origin%20%2D%2Ddelete%20.) to delete old branches don't work because my computer rejects the `date -d` option.

~~~bash
branches=$(git branch -r | sed 's/origin\///')
echo "$branches"
for branch in $branches; do
    last_commit_date=$(git show --no-patch --format=%ci "origin/$branch" | head -n 1)
    # git push origin --delete "$branch"
    echo "$branch :::: $last_commit_date"
done
~~~

Then you can delete the branches with eg.

~~~bash
#!/bin/bash

branches=(
"branch1"
"branch2"
"branch3"
)

for branch in "${branches[@]}"
do
    echo "Deleting branch: $branch"
    git push origin --delete "$branch"
    echo "Deleted branch: $branch"
    echo ""
done
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
