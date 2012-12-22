/def test2 = \
    /while ({#}) \
	/let _a=%{1} %; \
	/echo %_a %; \
	/shift %; \
	/test2 %{*} %; \
    /done