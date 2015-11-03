web
=====

An OTP application

Build
-----

    $ rebar3 compile

Deploy on Heroku
----

```
heroku create <app-name> --stack cedar-14 --region <region> --buildpack "https://github.com/heroku/heroku-buildpack-erlang"
heroku ps:scale web=1
heroku config:set RELX_REPLACE_OS_VARS=true
```

Setup environment variables:

```
RELX_REPLACE_OS_VARS=true
PORT=8080
```
