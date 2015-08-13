---
title: Solution to 'Invalid parameter number&#58; number of bound variables does not match number of tokens' when running CakePHP Unit Tests
tags: cakephp
---

<!-- Post Content -->
<p class="lead">I just came across this in my CakePHP app. Posting my fix here, to aid any of you error code googlers.

Turns out in my case the issue was just that one of my fixtures had an extra field in the $records array, which didn’t belong to that model / database table. Get rid of that, and the error disappears. Too easy!</p>
