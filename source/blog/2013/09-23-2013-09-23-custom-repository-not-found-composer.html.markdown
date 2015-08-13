---
title: Custom Repository not found by Composer
tags: cakephp
---

Using [these instructions](http://vvv.tobiassjosten.net/php/have-composer-use-development-branches/), I was trying to use my own custom repository with composer. I had forked the package `kamisama/cake-resque` to my own github account and was trying to include my own version in my project.

Here's a simplified version of my composer.json:

~~~ruby
{
    "repositories": [
        {
            "type": "vcs",
            "url": "https://github.com/joshuapaling/Cake-Resque.git"
        },
    ],
    "require": {
        "joshuapaling/cake-resque": "dev-master as 3.3.8"
    }
}
~~~
And here's the error I kept coming up against:

~~~markup
Loading composer repositories with package information
Updating dependencies (including require-dev)
Your requirements could not be resolved to an installable set of packages.

  Problem 1
    - The requested package joshuapaling/cake-resque could not be found in any version, there may be a typo in the package name.

Potential causes:
 - A typo in the package name
 - The package is not available in a stable-enough version according to your minimum-stability setting
   see <https://groups.google.com/d/topic/composer-dev/_g3ASeIFlrc/discussion> for more details.

Read <http://getcomposer.org/doc/articles/troubleshooting.md> for further common problems.
~~~

Turns out that if you use your own repository, you still need to use the original package name - in my case, `kamisama/cake-resque` rather than `joshuapaling/cake-resque`

So, my working composer.json looked like this:

~~~ruby
{
    "repositories": [
        {
            "type": "vcs",
            "url": "https://github.com/joshuapaling/Cake-Resque.git"
        },
    ],
    "require": {
        "kamisama/cake-resque": "dev-master as 3.3.8"
    }
}
~~~

The package name is actually defined in the package's own composer.json file - so even though I'd forked the package to my own `joshuapaling` github account, and the package was now residing at the URL `https://github.com/joshuapaling/Cake-Resque.git`, that had not influenced the package's name at all, from composers perspective.

A stupid error - but I'm new to composer, and it wasn't clear at first! So, I hope this helps someone else with the same problem.
