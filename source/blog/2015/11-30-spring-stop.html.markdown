---
title: Spring stop
tags:
published: true
layout: blog
---

A note for my own future reference: if you're using rails with spring, and you add a new class in a new file under a new folder in your /app directory (eg, adding your first service to an app at `/app/services/my_service.rb`), Rails will not find that new class until you've run `spring stop`.

If you're adding a new file to an existing subfolder under `app`, you're fine.