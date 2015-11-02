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
```

