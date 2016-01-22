-module(docsh_elixir_docs_v1).
-export([from_internal/1]).
-import(docsh_lib, [get/2]).

from_internal(Internal) ->
    Intermediate = [ Out || In <- Internal, Out <- [do(In)], Out /= ignore ],
    {[Docs], [ModDoc]} = proplists:split(Intermediate, [docs]),
    [{docs, proplists:get_all_values(docs, Docs)}, ModDoc].

%% TODO: `x`s below are only placeholders - find out what should be there
do({module, Info}) ->
    {moduledoc, {x, get(description, Info)}};
do({function, Info}) ->
    {docs, {{get(name, Info), get(arity, Info)},
	    x, def,
	    x,
	    get(description, Info)}}.
