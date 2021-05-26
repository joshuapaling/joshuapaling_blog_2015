---
title: Data imports done right
tags:
published: true
layout: blog
---

I’ve been bitten more than once by data imports consuming an unreasonable amount of time in software projects. Here are some lessons.

## Know what to expect

The client (or whoever is sourcing the data) will give you poor quality data from disparate sources, and they’ll drip-feed it over a period of way-too-long. Each version will be in a slightly different format. They’ll say “just get started with this” then want a complete re-do with fresh data later. They’ll give you the final copy, then the actual final copy, then the final FINAL copy. Eventually, you’ll get the real actual final renamed FINAL CONFIRMED copy. A few months after going live, they’ll want to import a bit more data that they forgot about the first time round. Expect this.

You will end up running your import scripts countless times, with dozens of variations in the data format supplied by the client.

## Know how to deal with it

### Your import scripts should be production level code

You and your team will run them enough to make this MORE than worth it. Write unit tests. Have tests for each edge case. Name them well. Where there’s cheap performance wins, take them. Commit them to the codebase with the expectation that they’ll live there for several months, minimum, and be used countless times.

### Your import scripts should be easily re-runnable

You should be able to re-run them with a single command — ./import.sh or whatever. You should not have to manually delete or otherwise wrangle around with data in the database, or csv files, or anything else, before re-running.

Your import scripts should take care of either: deleting all data before they re-run, or running in an idempotent kinda way so on the second run through, they’ll update the same existing record if it exists, rather than adding a duplicate.

## Your app (primarily your database schema) should dictate the data format for imports

When the client gives you a messy spreadsheet, it’s easy to think: “That’s Ok, I’ll write script that loops over this, untangles it, and imports it directly to the database”.

Don’t do this. Don’t let the mess of spreadsheets you’re provided with dictate the data formats used by your import scripts. Imagine if the app was in production and the client wanted a page where they could upload a CSV of additional data at any time, and expect to get understandable errors when data didn’t match the expected format. You’d have to dictate the format of the CSV. What would you ideally dictate? That’s the format your inport scripts should use.

This requires a little more thought and effort up front on your part, but it pays back in the long run.

If you have to deal with a dirty spreadsheet of data, the approach should be to write a (possibly dirty, throw-away) script to transform that data into the format your app expects (ie, a format closely matching your app’s database schema), then import the transformed data using your nice, production quality code.

Alternatively, don’t write script to transform messy data, and just tell the client: “This data isn’t in a suitable format. Here’s a template CSV with the headers we expect. Fill that out and send it back”.

### You mostly want one import per table. As the database schema changes, modify existing scripts; don’t add new ones.

Let’s say a client wants to give you data about restaurants. They have the restaurant names now — but will give you the addresses later. So, create a restaurants import script that handles just names now. Later, modify that same script to handle both names and addresses. Don’t create a second restaurant_addresses import script later. One script per table, modify it as the schema for that table changes.

Ideally, when the client says “I have the addresses data now”, you say “great — add it to this spreadsheet which already contains the names, and empty columns for the address data, then send that spreadsheet back to me”. Of course, since your expected CSV format closely matches your database schema, it’ll be easy to export a CSV of existing data using your favourite RDBMS client.

### Know who’s responsible for providing clean data

In almost all cases, the ultimate responsibility of providing clean data (or cleaning up bad data) should lie with the client. That should be clear in writing prior to starting the job.

Ideally, the job of getting that clean data into the most convenient format for your app should also lie with the client — that is, you should be able to say “here’s how the app’s import scripts expect the data to look”, and they’ll provide you data looking like that.

Both the above steps (getting clean data, and formatting it) ALWAYS take WAY longer than expected. So avoid those responsibilities if you can.

Of course, in practice, you’ll cut the client some slack and sometimes tidy up data for them. But having it clear in writing that cleaning and formatting data is their responsibility means after the 20th iteration of being provided unsuitable data, you can say “Stop! Get us clean data, and then we’ll continue. Or, pay us extra for cleaning up dirty data, because that work is outside scope.”

### Don’t be too preoccupied with getting “real” data in your app early on

It’s tempting to jump the gun and get “real” data in your app to make your dev or staging environment feel more complete or realistic, even when the data you’ve been provided so far is a messy, inconsistent or incomplete. Avoid this temptation.

The danger here is that every time you find a bug in the app, you’re never sure wether it’s a result of bad code, or bad data. Sticking to a smaller subset of “non-real” but clean, correct, consistent data ensures that when you do have a bug, you can be a lot more confident that the codebase, not the database, is where you should be trying to fix it.

Always make every effort to avoid having any inconsistent / incomplete data, even in the early stages of development / prototyping.

Maintain a small but complete and consistent subset of data that you can use for development, until ALL of the real data becomes available.

## Overestimate

Often the advice for estimating software projects is “decide how long you think it’ll take, then double it”. For data imports, multiplying by 4, or negotiating to do that part of the project hourly rather than fixed cost, is a safer bet.