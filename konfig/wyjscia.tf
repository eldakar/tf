;
; Plik     : wyjscia.tf
; Autor    : volus
; Poczatek : 19/10/2005, 22:48:49
; Koniec   :
; Opis     : Pokazywacz wyjsc na pasku, kolorowacz ich i zmieniacz ;)
;

/def itrigger = /test $[fake_recv({*})]

; Ostatnia modyfikacja: 19 X    2005
;                       28 VIII 2007

; Glowny, najwiekszy def, ktory bedzie lapal wszystkie opisy wyjsc, dostepne na Arce:

; nw|n|ne
; w|uXd|e  nietypowe
; sw|s|se

/def -F -P10BCyellow;12BCyellow -mregexp -t'(widoczn(e|ych) wyjsc(ia|ie|)( to|): |(wiedzie|rozgalezia sie|trakt wiodacy) na |prowadzi tutaj w (jednym|dwoch) (kierunku|kierunkach): |Wydeptane w kukurydzy sciezki prowadza na |rozlegle laki mozesz kontynuowac udajac sie na |prowadz[ia] tutaj w ([^ ]*) kierunkach: |Dostrzegasz wydeptana w kukurydzy sciezke prowadzaca na |Gorska sciezka konczy sie slepo, wiec mozesz jedynie cofnac sie na |Trakt jest zasypany glazami i mozna podazac nim tylko w jednym kierunku, na |Gorska sciezka rozwidla sie tutaj, umozliwiajac podroz na |Wijaca sie miedzy skalami, gorska sciezka prowadzi na |Mozesz (sie stad udac|podazac traktem) na )([^.]*)(\.$|\. Mozna jednak z niego zejsc i udac sie na ([^.]*))' _wyjscia = \
    /let exits1=$[replace("gore", "gora", replace(",", "", replace(" i ", " ", replace(" lub ", " ", replace(" albo ", " ", {P10})))))] %; \
    /let exits2=$[replace("gore", "gora", replace(",", "", replace(" i ", " ", replace(" lub ", " ", replace(" albo ", " ", {P12})))))] %; \
    /if (strlen(exits2)) \
        /let exits2=[$[replace(" ", "] [", exits2)]]%;\
    /endif %; \
;    /sprawdz_def %; \
    /let exits=%{exits1} %{exits2} %;\
    /if ({PL} =~ "W gestych ciemnosciach dostrzegasz ") \
        /set night_mode=1 %; \
    /else \
        /set night_mode=0 %; \
    /endif %; \
    /set actual_exits=%{exits} %; \
    /if (_lazik_ide) \
        /_idz $[replace("[", "", replace("]", "", exits))] %; \
    /endif %; \
    /if (wyjscia_mode == 1) \
        /pokaz_wyjscia %{exits} %;\
    /elseif (wyjscia_mode == 2) \
        /pokaz_wyjscia2 %{exits} %;\
    /else \
        /pokaz_wyjscia_n %{exits}%;\
    /endif

/def wyjscia = \
    /if ({*}=~NULL) \
        /pecho Uzycie: /wyjscia (0/1/2) %;\
        /pecho Rozny pokazywacz wyjsc%;\
        /return %;\
    /endif %; \
    /if ({1} == 1) \
        /set wyjscia_mode=1%;\
        /pecho Pokazywacz wyjsc: 1 (roza wiatrow)%;\
    /elseif ({1} == 2) \
        /set wyjscia_mode=2%;\
        /pecho Pokazywacz wyjsc: 2 (nw, ne, e, s)%;\
    /else \
        /set wyjscia_mode=0%;\
        /pecho Pokazywacz wyjsc: 0 (polnoc, poludnie, wschod)%;\
    /endif

/wyjscia 0

/def wyjscia_przelacz = \
    /if (wyjscia_mode == 0) \
        /wyjscia 1 %; \
    /elseif (wyjscia_mode == 1) \
        /wyjscia 2 %; \
    /elseif (wyjscia_mode == 2) \
        /wyjscia 0 %; \
    /else \
        /pecho Cos nie tak, liczba wyjscia_mode przekracza standard!%;\
    /endif


/def pokaz_wyjscia_n = \
    /if (night_mode) \
        /repeat -0 1 \
            /echo -p @{Cgreen}Exits: @{nCyellow}$[replace(" ", ", ", exits)]%;\
            \
    /else \
        /repeat -0 1 \
            /echo -p @{Cgreen}Exits: @{nBCyellow}$[replace(" ", ", ", exits)]%;\
            \
    /endif
/def pokaz_wyjscia2 = \
    /if (night_mode) \
        /repeat -0 1 \
            /echo -p @{Cgreen}Exits: @{nCyellow}$[replace("polnoc", "n", \
                                          replace("poludnie", "s", \
                                          replace("wschod", "e", \
                                          replace("zachod", "w", \
                                          replace("polnocny-zachod", "nw", \
                                          replace("polnocny-wschod", "ne", \
                                          replace("poludniowy-zachod", "sw", \
                                          replace("poludniowy-wschod", "se", \
                                          replace("gora", "u", \
                                          replace("dol", "d", \
                                          replace(" ", ", ", exits)))))))))))]%;\
            \
    /else \
        /repeat -0 1 \
            /echo -p @{Cgreen}Exits: @{nBCyellow}$[replace("polnoc", "n", \
                                          replace("poludnie", "s", \
                                          replace("wschod", "e", \
                                          replace("zachod", "w", \
                                          replace("polnocny-zachod", "nw", \
                                          replace("polnocny-wschod", "ne", \
                                          replace("poludniowy-zachod", "sw", \
                                          replace("poludniowy-wschod", "se", \
                                          replace("gora", "u", \
                                          replace("dol", "d", \
                                          replace(" ", ", ", exits)))))))))))]%;\
    /endif

; \ | /   ^
; - + -  wyjscie
; / | \   v

/def pokaz_wyjscia = \
    /while ({#}) \
        /if (substr({1}, 0, 1) =~ "[") \
            /let _hidden=1%; \
        /else \
            /let _hidden=0%; \
        /endif %; \
        /let _checking_exit=$[replace("[", "", replace("]", "", {1}))] %;\
        /if (_checking_exit =~ "polnoc") \
            /if (_hidden) \
                /let _w_n=$[decode_attr("@{Cyellow}|@{n}")]%; \
            /else \
                /if (night_mode) \
                    /let _w_n=$[decode_attr("@{Cgreen}|@{n}")]%; \
                /else \
                    /let _w_n=$[decode_attr("@{BCgreen}|@{n}")]%; \
                /endif %; \
            /endif %; \
        /elseif (_checking_exit =~ "poludnie") \
            /if (_hidden) \
                /let _w_s=$[decode_attr("@{Cyellow}|@{n}")]%; \
            /else \
                /if (night_mode) \
                    /let _w_s=$[decode_attr("@{Cgreen}|@{n}")]%; \
                /else \
                    /let _w_s=$[decode_attr("@{BCgreen}|@{n}")]%; \
                /endif %; \
            /endif %; \
        /elseif (_checking_exit =~ "wschod") \
            /if (_hidden) \
                /let _w_e=$[decode_attr("@{Cyellow}-@{n}")]%; \
            /else \
                /if (night_mode) \
                    /let _w_e=$[decode_attr("@{Cgreen}-@{n}")]%; \
                /else \
                    /let _w_e=$[decode_attr("@{BCgreen}-@{n}")]%; \
                /endif %; \
            /endif %; \
        /elseif (_checking_exit =~ "zachod") \
            /if (_hidden) \
                /let _w_w=$[decode_attr("@{Cyellow}-@{n}")]%; \
            /else \
                /if (night_mode) \
                    /let _w_w=$[decode_attr("@{Cgreen}-@{n}")]%; \
                /else \
                    /let _w_w=$[decode_attr("@{BCgreen}-@{n}")]%; \
                /endif %; \
            /endif %; \
        /elseif (_checking_exit =~ "polnocny-wschod") \
            /if (_hidden) \
                /let _w_ne=$[decode_attr("@{Cyellow}/@{n}")]%; \
            /else \
                /if (night_mode) \
                    /let _w_ne=$[decode_attr("@{Cgreen}/@{n}")]%; \
                /else \
                    /let _w_ne=$[decode_attr("@{BCgreen}/@{n}")]%; \
                /endif %; \
            /endif %; \
        /elseif (_checking_exit =~ "polnocny-zachod") \
            /if (_hidden) \
                /let _w_nw=$[decode_attr("@{Cyellow}\@{n}")]%; \
            /else \
                /if (night_mode) \
                    /let _w_nw=$[decode_attr("@{Cgreen}\@{n}")]%; \
                /else \
                    /let _w_nw=$[decode_attr("@{BCgreen}\@{n}")]%; \
                /endif %; \
            /endif %; \
        /elseif (_checking_exit =~ "poludniowy-wschod") \
            /if (_hidden) \
                /let _w_se=$[decode_attr("@{Cyellow}\@{n}")]%; \
            /else \
                /if (night_mode) \
                    /let _w_se=$[decode_attr("@{Cgreen}\@{n}")]%; \
                /else \
                    /let _w_se=$[decode_attr("@{BCgreen}\@{n}")]%; \
                /endif %; \
            /endif %; \
        /elseif (_checking_exit =~ "poludniowy-zachod") \
            /if (_hidden) \
                /let _w_sw=$[decode_attr("@{Cyellow}/@{n}")]%; \
            /else \
                /if (night_mode) \
                    /let _w_sw=$[decode_attr("@{Cgreen}/@{n}")]%; \
                /else \
                    /let _w_sw=$[decode_attr("@{BCgreen}/@{n}")]%; \
                /endif %; \
            /endif %; \
        /elseif (_checking_exit =~ "gora") \
            /if (_hidden) \
                /let _w_u=$[decode_attr("@{Cyellow}^@{n}")]%; \
            /else \
                /if (night_mode) \
                    /let _w_u=$[decode_attr("@{Cgreen}^@{n}")]%; \
                /else \
                    /let _w_u=$[decode_attr("@{BCgreen}^@{n}")]%; \
                /endif %; \
            /endif %; \
        /elseif (_checking_exit =~ "dol") \
            /if (_hidden) \
                /let _w_d=$[decode_attr("@{Cyellow}v@{n}")]%; \
            /else \
                /if (night_mode) \
                    /let _w_d=$[decode_attr("@{Cgreen}v@{n}")]%; \
                /else \
                    /let _w_d=$[decode_attr("@{BCgreen}v@{n}")]%; \
                /endif %; \
            /endif %; \
        /else \
            /let _w_nt=%{1}%;\
        /endif%;\
        /shift %;\
    /done%;\
    /let _wyjscia=$[decode_attr(strcat("@{Cgreen}", replace("polnoc", "n", replace("poludnie", "s", replace("wschod", "e", replace("zachod", "w", replace("polnocny-zachod", "nw", replace("polnocny-wschod", "ne", replace("poludniowy-zachod", "sw", replace("poludniowy-wschod", "se", replace("gora", "u", replace("dol", "d", replace(" ", ", ", exits))))))))))), "@{n}"))]%;\
    /if (night_mode) \
        /let _tl1=$[decode_attr("@{Cgreen}    \  @{n}")] %; \
        /let _tl2=$[decode_attr("@{Cgreen}   ==] @{n}")] %; \
        /let _tl3=$[decode_attr("@{Cgreen}    /  @{n}")] %; \
    /else \
        /let _tl1=$[decode_attr("@{BCgreen}    \  @{n}")] %; \
        /let _tl2=$[decode_attr("@{BCgreen}   ==] @{n}")] %; \
        /let _tl3=$[decode_attr("@{BCgreen}    /  @{n}")] %; \
    /endif %; \
    /set _1_linia=%{_tl1}$[pad(" ",     -30, _w_nw, 1, _w_n, 1, _w_ne, -3, " ", 1, _w_u, 1)]%;\
    /set _2_linia=%{_tl2}$[pad(_wyjscia, -30, _w_w,  1,  "O", 1, _w_e,  -2, _w_nt,      -10)]%;\
    /set _3_linia=%{_tl3}$[pad(" ",      -30, _w_sw, 1, _w_s, 1, _w_se, -3, " ", 1, _w_d, 1)]%;\
    /test pokaz_roze_wiatrow(_1_linia, _2_linia, _3_linia)

/def pokaz_roze_wiatrow = \
    /echo -p @{n}%{1}%;\
    /echo -p @{n}%{2}%;\
    /echo -p @{n}%{3}%;\
    /unset _1_linia%; \
    /unset _2_linia%; \
    /unset _3_linia


/def show_exits = \
    /while ({#}) \
	/echo Exit: %{1}%; \
	/shift %; \
    /done


;\. Mozna jednak z niego zejsc i udac sie na
;\. Po obydwu stronach uliczki znajduja sie sklepy.'
;Wedrowke przez rozlegle laki mozesz kontynuowac w dowolnie wybranym kierunku.
;Mozesz stad wyruszyc w dowolnie wybranym kierunku
;\. Natomiast (jesli chcesz|aby) zejsc z wytyczonej drogi (wystarczy|m(usisz|ozesz)) udac sie (na|w) |