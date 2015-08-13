---
title: Spree Search (IRC Log)
tags: spree
published: false
---


[10:57:33] <brchristian>  this seems to be coming from a SQL query that is (A) looking through all product fields including description (B) using OR rather than AND when chaining multiple search terms (C) using %LIKE% so it matches partial words, and (D) ordering results by date for sale rather than any kind of relevance

[10:57:48] <brchristian>  I'd question the soundness of (A) (B) (C) and (D) !

[10:58:08] <@Radar>  brchristian: The searching inside of Spree is not designed to meet the needs of everyone.

[10:58:12] <brchristian>  is there a way to use a decorator to fix things like that, or is my only real option going third-party?

[10:58:16] <@Radar>  It's a very, very basic search implementation

[10:58:27] <@Radar>  You should implement solr or thinking-sphinx instead.

[10:58:32] <brchristian>  @Radar fair enough

[10:58:32] <@Radar>  or elastic search

[10:58:39] <@Radar>  no, there isn't a guide for that

[10:58:41] <@Radar>  yes, there should be

[10:58:44] <@Radar>  patches welcome

[10:58:50] <brchristian>  you've anticipated my queries :)

[10:59:16] <brchristian>  cool, the only thing I could find on Google at all was from your website and looked pre-1.0 : http://ryanbigg.com/spree-guides/searching.html
