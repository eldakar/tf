; 12 m = 1s
; 20 s = 240m = 1z
; 100 z = 24000m = 1mith

/def -F -mregexp -t'^Wydaje ci sie, ze jest wart(a|) okolo (.*) miedziak.+\.' _ocen_przedmiot_kasa = \
    /let _res=%{P2} %; \
    /let _mith=$[expr(_res / 24000)] %; \
    /if (_mith > 0) \
	/let _res=$[expr(_res - (_mith * 24000))] %; \
    /endif %; \
    /let _zl=$[expr(_res / 240)] %; \
    /if (_zl > 0) \
	/let _res=$[expr(_res - (_zl * 240))] %; \
    /endif %; \
    /let _sr=$[expr(_res / 12)] %; \
    /if (_sr > 0) \
	/let _res=$[expr(_res - (_sr * 12))] %; \
    /endif %; \
    /substitute -p %{PL}%{P0}%{PR} (@{BCmagenta}%{_mith} mth@{n} @{BCyellow}%{_zl} zl@{n} @{BCwhite}%{_sr} sr@{n} @{BCrgb211}%{_res} miedz@{n})