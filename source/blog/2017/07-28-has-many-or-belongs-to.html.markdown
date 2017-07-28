---
title: ToDo
tags: ToDo
published: false
---

Sebastion gave a talk: no circular dependencies. Most commmon is "hasMany" and "belongsTo". Pick one or the other. Factors influencing your decision:

If child belongsTo parent:

Can child's parent_id ever change? If so, lean towards belongsTo. If not, lean towards hasMany.

Do you ever view child on it's own? Or is it always viewed alongside all the other children of it's same parent? If the former, lean towards belongsTo. If the later, hasMany.

Your choices are:

child belongsTo parent:
- fetching child and including parent is easy.
- fetching parent and including children is impossible. YOu have to first fetch parent, call Child.where(parent_id: parent.id), and you have separate variables for child and parent.

parent hasMany children:
- fetching parent and including children is easy.
- fetching a child and including the parent is impossible. You have to first fetch the child, then say Parent.find_by_id(child.parent_id), and you have separate variables for child and parent.
