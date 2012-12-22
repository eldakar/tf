;
; Plik  : wiz.tf
; Autor : volus
; Data  : czw lis 24 15:21:52 CET 2005
; Opis  : Kolorki i inne takie rzeczy dla wizardow
;

/eval /set _wiz_tell_plik=/tmp/tellz_%{_obecny_gracz}

/test fwrite(_wiz_tell_plik, encode_ansi(decode_attr("@{BCgreen}-- W tym pliku beda zapisywane telle / wizline / domenowe telle --")))

/def wyslij_text_do_pliku = \
    /test fwrite(_wiz_tell_plik, {*})

/def ustaw_zmienna_czasu = \
    /set czas=$[ftime("%H:%M:%S")]

/def wiz_sending = \
    /if ({*} =~ NULL) \
        /pecho Blad skladni! Napisz /wiz_sending help %; \
        /return %; \
    /elseif ({*} =~ "help") \
        /pecho Dostepne opcje: %;\
        /pecho - /wiz_sending +%;\
        /pecho - /wiz_sending -%;\
        /return %; \
    /elseif ({*} =~ "+") \
        /set _wiz_no_send_info=0%; \
        /set _wiz_send_info=1%; \
        /pecho Wysylanie wlaczone!%; \
        /return %; \
    /elseif ({*} =~ "-") \
        /set _wiz_send_info=0%; \
        /set _wiz_no_send_info=1%; \
        /pecho Wysylanie wylaczone!%; \
        /return %; \
    /else \
        /pecho Blad skladni! Napisz /wiz_sending help %; \
    /endif

;      O co chodzi z tym wysylaniem? Otoz:
; Screen ma taki myk, ze moze dzielic okno na dwie lub wiecej 'polowek'
; Jesli do .screenrc dopiszemy takie o linie:
;
; split
; resize +10
; focus down
; screen tail -f /tmp/tellz
; focus up
; screen tf -f".tfrc"
;
; a w pliku wiz.tf ustawiamy /wiz_sending +
; to wtedy wszystki telle / wizline / telle domenowe / odpowiedzi, whatever
; beda wysylane do pliku /tmp/tellz, ktorego kolory sa przekodowane do
; znakow ansi, ktory to 'tail' odczytuje ladnie kolorow
;
; czyli dzielimy okienko na 2, na jednym odpalamy tail tego pliku na drugim
; sesje tf'a i mamy ladnie podzielone okienko
;
; oczywiscie odpalamy screena a nie tf'a ;)

;-------------------- z wysylaniem do pliku -----------------------------------

/def -F -ag -E(_wiz_send_info&code_mode) -mregexp -t' odpowiada: '           _sub_ktos_odpowiada_slij = \
    /ustaw_zmienna_czasu %; \
    /let _var=@{BCyellow}[%{czas}]  Odp od @{n}%{PL}: @{nBCwhite}%{PR} %; \
    /eval /wyslij_text_do_pliku $[encode_ansi(decode_attr(_var))] %; \
    /set _who_last_tell=$[tolower({PL})] %; \
    /beep

/def -F -ag -E(_wiz_send_info&code_mode) -mregexp -t'^You tell ([^ ]*): '    _sub_you_tell_slij = \
    /ustaw_zmienna_czasu %; \
    /let _var=@{Cgreen}[%{czas}]    Do   @{n}%{P1}: @{BCwhite}%{PR}%; \
    /eval /wyslij_text_do_pliku $[encode_ansi(decode_attr(_var))]

/def -F -ag -E(_wiz_send_info&code_mode) -mregexp -t' tells you: '       _sub_tells_you_slij = \
    /ustaw_zmienna_czasu %; \
    /let _var=@{BCgreen}[%{czas}] Tell od @{n}%{PL}: @{BCwhite}%{PR}%;\
    /eval /wyslij_text_do_pliku $[encode_ansi(decode_attr(_var))] %; \
    /set _who_last_tell=$[tolower({PL})] %; \
    /beep

/def -p150 -ag -E(_wiz_send_info&code_mode) -mregexp -t'^\<([^ ]*)\> ([^ ]*) '     _sub_domena_slij = \
    /ustaw_zmienna_czasu %; \
    /let _var=@{BCcyan}[%{czas}] @{B}%{P1} =] @{n}%{P2} @{BCwhite}%{PR}%; \
    /eval /wyslij_text_do_pliku $[encode_ansi(decode_attr(_var))]

/def -p150 -ag -E(_wiz_send_info&code_mode) -mregexp -t'^\@ ([^ ]*)'            _sub_wizline_slij = \
    /ustaw_zmienna_czasu %; \
    /let _var=@{Cyellow}[%{czas}] @{n}%{P1}@{BCwhite}%{PR}%; \
    /eval /wyslij_text_do_pliku $[encode_ansi(decode_attr(_var))]

;------------------ bez wysylania do pliku ------------------------------------

/def -F -E(_wiz_no_send_info&code_mode) -mregexp -t' odpowiada: '           _sub_ktos_odpowiada = \
    /ustaw_zmienna_czasu %; \
    /substitute -p @{BCyellow}[%{czas}]  Odp od @{n}%{PL}: @{nBCwhite}%{PR} %; \
    /set _who_last_tell=$[tolower({PL})] %; \
    /beep

/def -F -E(_wiz_no_send_info&code_mode) -mregexp -t'^You tell ([^ ]*): '    _sub_you_tell = \
    /ustaw_zmienna_czasu %; \
    /substitute -p @{Cgreen}[%{czas}]    Do   @{n}%{P1}: @{BCwhite}%{PR}

/def -F -E(_wiz_no_send_info&code_mode) -mregexp -t' tells you: '           _sub_tells_you = \
    /ustaw_zmienna_czasu %; \
    /substitute -p @{BCgreen}[%{czas}] Tell od @{n}%{PL}: @{BCwhite}%{PR} %;\
    /set _who_last_tell=$[tolower({PL})] %; \
    /beep


/def -p150 -E(_wiz_no_send_info&code_mode) -mregexp -t'^\<([^ ]*)\> ([^ ]*) '     _sub_domena = \
    /ustaw_zmienna_czasu %; \
    /substitute -p @{BCcyan}[%{czas}] @{B}%{P1} =] @{n}%{P2} @{B}%{PR}

/def -ab -p150 -E(_wiz_no_send_info&code_mode) -mregexp -t'^\@ ([^ ]*)'            _sub_wizline = \
    /beep %; \
    /ustaw_zmienna_czasu %; \
    /substitute -p @{Cyellow}[%{czas}] @{nBCwhite}[@] @{n}%{P1}@{B}%{PR}

;------------------------------------------------------------------------------

/wiz_sending -

;------------------------------------------------------------------------------

/def -F -mregexp -t'^PRZYZWANIE '	_sub_przyzwanie = \
    /ustaw_zmienna_czasu %; \
    /beep 1%; \
    /echo %; \
    /substitute -p @{BCyellow}[%{czas}] * @{nBCwhite}Przyzwanie * %{PR}%; \
    /repeat -0 1 /echo


/def -Fp5 -E(code_mode) -mregexp -P0Cyellow;RCyellow -t"(\/[bcdeloprs]\/|\~[a-z])" _hilite_sciezek
/def -F -mregexp -P0BCwhite -t'\*'  _hilite_gwiazdki

/def -Fp5 -E(code_mode) -mregexp -P0Ccyan   -t'([^ ]*)\.c(\*|)\b'       _pliki_c
/def -Fp5 -E(code_mode) -mregexp -P0Cyellow -t'([^ ]*)\.h\b'            _pliki_h
/def -Fp5 -E(code_mode) -mregexp -P0Cred    -t'([^ ]*)\.o\b'            _pliki_o
/def -Fp10 -E(code_mode) -mregexp -P0Cgreen -t'([^ ]*)/'                _pliki_k

;/def -Fp15 -mregexp -P1BCmagenta -t'([^ ]*)\.([^cho])\B' _test
;[Loudernn logged in.]

/def -F -aBCgreen -mregexp -t'logged in'     _someone_logged_in
/def -F -aCgreen  -mregexp -t'logged out'    _someone_logged_out


/def -Fp3 -E(code_mode) -mregexp -P0BCcyan    -t'(?-i)(int|status|function|string|object|mapping|mixed|void|inherit)'  _kolor_typy
/def -Fp5 -E(code_mode) -mregexp -P0BCyellow  -t'#([^ ]*)'                                                      _kolor_preprocesor
/def -F -E(code_mode) -mregexp -P0n;0Cyellow  -t'\"([^\"]*)\"'                                                  _kolor_string

/def -Fp4 -mregexp -E(code_mode) -P0BCmagenta -t'[+=\-&|^<>*%/!~?:]'                                            _kolor_operatory

/def cm = /code_mode %{*}

/def code_mode = \
    /if ({1} =~ "on") \
        /set code_mode=1%;\
        /set sub=off%; \
        /echo Code Mode: On%; \
    /elseif ({1} =~ "off") \
        /set code_mode=0%;\
        /set sub=full%; \
        /echo Code Mode: Off%; \
    /else \
        /echo /code_mode [on|off]?%; \
    /endif

/cm on

;; /def -p2 -E(code_mode) -P0Cwhite;RCwhite -mregexp -t'(//|/\\*.*\\*/)'      _komentarz_jednoliniowy

;; /def -p1 -E(code_mode) -mregexp -t'/\\*'      _komentarz_wieloliniowy = \
;;     /substitute -p @{n}%{PL}@{Cwhite}%{P0}%{PR} %; \
;;     /def -p10 -P0Cwhite -mregexp -t'.*'       _kolorujemy_komentarz %; \
;;     /def -p15 -mregexp -t'\\*/'   _koniec_komentarza_wieloliniowego = \
;;         /undef _kolorujemy_komentarz%%; \
;;         /undef _koniec_komentarza_wieloliniowego%%; \
;;         /substitute -p @{Cwhite}%%{PL}%%{P0}@{n}%%{PR}


/def kod = \
    /quote -0 -dsend '%{*}

;; mark to alias w aliasy.tf
/alias load mark %; /send errlog -r %; /send load %*

/def r = \
    tell %{_who_last_tell} %{*}

/def rwho = \
    /echo -p @{BCwhite}Bedziesz odpowiadal: @{nCgreen}%{_who_last_tell-nikomu}

;;;;;;;;;;;; niektore aliasy

/alias ls cd .%; /send ls -F %*

/def cz = \
    /let _var=$[rand(0,10)] %; \
    /if (_var == 0) \
        /let _str=Witam.%; \
    /elseif (_var == 1) \
        /let _str=Czesc.%; \
    /elseif (_var == 2) \
        /let _str=Hej.%; \
    /elseif (_var == 3) \
        /let _str=Hello.%; \
    /elseif (_var == 4) \
        /let _str=Cem!%; \
    /elseif (_var == 5) \
        /let _str=Hejka.%; \
    /elseif (_var == 6) \
        /let _str=Cz.%; \
    /elseif (_var == 7) \
        /let _str=Siema.%; \
    /elseif (_var == 8) \
        /let _str=Hi.%; \
    /elseif (_var == 9) \
        /let _str=Oi!%; \
    /elseif (_var == 10) \
        /let _str=Re.%; \
    /else \
        /let _str=Dobry!%; \
    /endif %; \
    /send wiz %{_str}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/def wrzuc = \
    /sys wrzucc

/af8 -q /wrzuc

/set secho_attr=BCwhite
/set sprefix==]
; /secho on


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Def do odpalania edytora tekstowego (w moim przypadku kate) przy
;;;;; wykorzystywaniu narzedzia bledow Mithandira
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/set _edytor=kate
/set _edytor_oczekuje=0
/set _opcje_edytora=-u

/set _login=lpmud\!rindarin
/set _host=arkadia.rpg.pl

/def bedit = \
    /if ({*} =~ null) \
        /send exec return this_player()->query_prop("_wiz_s_last_bug_filename");%;\
        /set _edytor_oczekuje=1%;\
    /else \
        /send bpok %{1} %; \
        /send exec return this_player()->query_prop("_wiz_s_last_bug_filename");%;\
        /set _edytor_oczekuje=1%;\
    /endif

/def -Fp5 -ag -mregexp -E(_edytor_oczekuje) -t'Result = \"(.*)\"' _bug_ok = \
    /odpalaj %{_edytor} %{_opcje_edytora} ftp:\\/\\/%{_login}\\@%{_host}%{P1} %; \
    /set _edytor_oczekuje=0

/def -Fp10 -mregexp -E(_edytor_oczekuje) -aBCwhite -t'Indeks poza zakresem' _bug_nieok =\
    /set _edytor_oczekuje=0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; Def do odpalania edytora tekstowego (w moim przypadku kate) przy
;;;;; wykorzystywaniu aktualnego path
;;;;; uzycie: /edit plik.c, wykorzystam pewne zmienne z w/w skryptu
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/set _edytor_oczekuje2=0

/def eedit = \
    /if ({*} =~ null) \
        /pecho Uzycie: /edit plik.c %; \
        /return %; \
    /else \
        /send exec return this_player()->query_path();%;\
        /set _edytor_oczekuje2=1%;\
        /set _edytor_filename=%{1} %; \
    /endif

/def -Fp5 -ag -mregexp -E(_edytor_oczekuje2) -t'Result = \"(.*)\"' _edytor_ok = \
    /odpalaj %{_edytor} %{_opcje_edytora} ftp:\\/\\/%{_login}\\@%{_host}%{P1}\\/%{_edytor_filename} %; \
    /set _edytor_oczekuje2=0 %; \
    /set _edytor_filename=0

;;;;; do bindowania stron www :)
/set _przegladarka=firefox
/set _opcje_przegladarki=

/def -F -p200 -mregexp -t'http\://[^ ]*' _bind_www = \
    /f8 /odpalaj %{_przegladarka} %{_opcje_przegladarki} "%{P0}"


/def -Fp150 -P0BCred -t'(rindarin|rind)' _highlight_names 
     