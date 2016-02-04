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
    Port = list_to_integer(web:get_env(port, "8080")),
    ok = case cowboy:start_http(
                web_http_listener, 100,
                [{port, Port}],
                [{env, [{dispatch, Dispatch}]}]) of
             {ok, _} -> ok;
             {error, {already_started, _}} -> ok;
             {error, _} = Error -> Error
         end,
    'web_sup':start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================

routes() ->
  [
    {"/",       cowboy_static, {priv_file, web, "index.html"}},
    {"/[...]",  cowboy_static, {priv_dir,  web, "",
                                    [{mimetypes, cow_mimetypes, all}]}}
  ].
