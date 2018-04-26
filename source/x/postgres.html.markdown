---
title: Postgres
---

<h1>Postgres</h1>

psql

`\l` or `\list` list databases

## Dump heroku DB:

~~~markup
heroku pg:backups capture
curl -o latest.dump `heroku pg:backups public-url -a your-app-name`
~~~
More info [here](https://devcenter.heroku.com/articles/heroku-postgres-import-export)


copy heroku prod to staging:

~~~markup
heroku pg:copy prod-svc-ee-offer-syd::DATABASE_URL DATABASE_URL --app test-svc-ee-offer-syd
~~~

## Postgres heroku import local database:

Export your local db with:

~~~markup
pg_dump -Fc --no-acl --no-owner -h localhost -U joshuapaling YOUR_DB_NAME > YOUR_FILE_NAME.dump
~~~

Then, get the credentials of your postgres database with:

~~~markup
heroku pg:credentials DATABASE_URL
# DATABASE_URL is literally just that string, as it is - don't substitute it for an actual url.
~~~

(You can use these credentials to connect with a GUI client if you want)

Then restore:

~~~markup
pg_restore --verbose --clean --no-acl --no-owner -h HOSTNAME -U USERNAME -d DATABASE_NAME -p 5432 PATH_TO_DUMP_FILE
~~~

EG:

~~~markup
pg_restore --verbose --clean --no-acl --no-owner -h ec2-11-11-111-111.compute-1.amazonaws.com -U josspaling -d abc123secret -p 5432 ../database.dump
~~~

More info [here](http://stackoverflow.com/questions/11890084/importing-a-postgresql-dump-to-heroku) and [here](https://devcenter.heroku.com/articles/heroku-postgres-import-export)


# clear stale PID file (when postgres isn't starting on mac)

~~~markup
cd /Volumes/Macintosh\ HD/usr/local/var/postgres/
rm -r postmaster.pid
~~~

# Shortcuts at console

~~~markup
\l
\d (display databases)
\dT+ (display enums with details)
~~~
