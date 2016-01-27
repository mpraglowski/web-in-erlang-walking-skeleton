%%%-------------------------------------------------------------------
%% @doc web API
%% @end
%%%-------------------------------------------------------------------

-module(web).

-export([start/0, stop/0]).
-export([get_env/1, get_env/2, set_env/2]).

%%====================================================================
%% API
%%====================================================================

-spec start() -> ok | {error, any()}.
start() ->
    case application:ensure_all_started(?MODULE) of
        {ok, _} -> ok;
        {error, {already_started, _}} -> ok;
        {error, _} = Error -> Error
    end.

-spec stop() -> ok | {error, any()}.
stop() ->
    case application:stop(?MODULE) of
        ok -> ok;
        {error, {not_started, ?MODULE}} -> ok;
        {error, _} = Error -> Error
    end.

-spec get_env(atom()) -> any() | no_return().
get_env(Key) ->
    case application:get_env(?MODULE, Key) of
        {ok, Value} -> Value;
        undefined   -> error({missing_config_value, Key})
    end.

-spec get_env(atom(), any()) -> any().
get_env(Key, Default) ->
    application:get_env(?MODULE, Key, Default).

-spec set_env(atom(), any()) -> ok.
set_env(Key, Value) ->
    ok = application:set_env(?MODULE, Key, Value).
