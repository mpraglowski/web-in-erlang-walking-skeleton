web-skeleton
=====

A basic setup for website with Erlang & Cowboy.
Simple setup serving static files from `priv` folder.
All tasks compile/build/release/run with `rebar3` (and some plugins).

Build
-----

    $ make

Prepare release
-----

    $ make rel

Setup on Heroku
----

```
heroku login
heroku create <app-name> --stack cedar-14 --region <region> --buildpack "https://github.com/heroku/heroku-buildpack-erlang"
heroku ps:scale web=1
heroku config:set RELX_REPLACE_OS_VARS=true
git push heroku master
```
