%%%-------------------------------------------------------------------
%% @doc web public API
%% @end
%%%-------------------------------------------------------------------

-module('web_app').

-behaviour(application).

%% Application callbacks
-export([start/2
        ,stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([{'_', routes() }]),
    Port = port(),
    {ok, _} = cowboy:start_http(web_http_listener, 100, [{port, Port}],
                                 [{env, [{dispatch, Dispatch}]}]
                               ),
    'web_sup':start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================

port() ->
  case os:getenv("PORT") of
    false -> 8080;
    Value -> list_to_integer(Value)
  end.

routes() ->
  [
    {"/",       cowboy_static, {priv_file, web, "index.html"}},
    {"/[...]",  cowboy_static, {priv_dir,  web, "",
                                    [{mimetypes, cow_mimetypes, all}]}}
  ].
