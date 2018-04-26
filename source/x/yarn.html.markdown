---
title: Yarn
---

<h1>Yarn</h1>

Notes from convo with Jocke in SMU slack on yarn.lock changing on yarn install:

joss [6:26 PM]
Figured it out.

So if you start with installing `"react": "*"`, then each time you `yarn install` it will NOT upgrade you, even if a new version is available.
You’d have to do `yarn upgrade react`
BUT if you CHANGE package.json, from `"react": "15.0.0"` to `"react": "*"` then the way it works is it basically says “OK, no one needs `"react": "15.0.0"`, that dependency is gone. Oh, and here’s a new dependency… `"react": "*"` - to satisfy that we’ll install the latest version. So it considers those deps as separate, even though they’re “the same but just with different versions”.
Let’s say you had: `"react": "^15.0.0"` which was currently being satisfied in your lockfile by version 15.1.1. And then, you changed `package.json` to `"react": "^15.1.0"`, or even `"react": ">1.0.0"`, BOTH of which are satisfied by that 15.1.1 version in your lockfile… it will still just scrap the `"react": "^15.0.0"` dependency, and the 15.1.1 version that’s currently satisfying it, and it’ll treat those updated versions as a dependency to fulfil “from scratch”.
So, I was kinda right: using `*` from the beginning won’t update every time you install.
But, if we switch to `*` now, to do that without upgrading, we have to hack the lockfile ourselves.
After updating package.json, this is the change you’d have to manually make to the lockfile in order to prevent the next `yarn install` from upgrading it:


joss [6:35 PM]
So to me that kinda makes sense - if you change a version in your package.json, you DO want to update to that version on the next `yarn install`, most of the time.
But it’s a bummer that you can’t just say “I don’t want to upgrade anything now, but I want to change from `15.0.0` to `^15.0.0` or `*` or whatever right now, for when I do upgrade in future.
But using `*` is safe for CI and everything. It’s just that “the first time you switch to `*`” you have to upgrade, and then after that, you don’t unless you explicitly run `yarn upgrade`