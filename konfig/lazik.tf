;
; Plik  : lazik.tf
; Autor : volus
; Data  : 26/06/2006, 16:59:22
; Opis  : no lazik no ;) dziala rekurencyjnie, przy kazdym kroku odpala sie
;         komenda /idz
;
; last update - 27 lutego 2007 - zmienilem tak, ze jesli delay jest wiekszy od
;               pol sekundy, wtedy dajemy delay losowy od 0 do 1 sek
;               oraz dodaje opcje -e, bedzie sie wykonywala czynnosc przy
;               kazdorazowym wejsciu na lokacje (przydatne np do autozielarza)

; ------------ konfiguracja
/def lazik_conf = \
    /if ({1} !~ "auto" & {1} !~ "bind" & {1} !~ "komenda") \
        /mesg Blad skladni!%;\
        /mesg Poprawna: /lazik_conf auto %; \
        /mesg Lub     : /lazik_conf bind ktory (tylko efy) np:%;\
        /mesg ....... : /lazik_conf bind f3    (wtedy binduje pod f3)%;\
        /mesg Lub     : /lazik_conf komenda (wtedy /idz next) %; \
        /return %;\
    /endif %; \
    /unset _lazik_bind %; \
    /unset _lazik_tryb %; \
    /if ({1} =~ "bind") \
        /if ({2} =~ NULL) \
            /mesg Nie podales ktory ktory ef mam bindowac, lecz standard to /f12 ... %;\
            /set _lazik_bind=f12 %; \
        /else \
            /set _lazik_bind=%{2}%; \
        /endif %; \
    /endif %; \
    /set _lazik_tryb=%{1}%; \
    /if (_lazik_bind !/ "") \
        /mesg Lazik skonfigurowany: %{_lazik_tryb}: %{_lazik_bind} %; \
    /else \
        /mesg Lazik skonfigurowany: %{_lazik_tryb}%;\
    /endif

/lazik_conf auto

; ------------------------ dzialanie

/def _stop_lazik = \
    /rstop idz          %; \
    /unset _lazik_ide   %; \
    /unset _lazik_czas  %; \
    /unset _przeciwny   %; \
    /unset _opcja_kom_lazika

/def -F -aCred -E(_lazik_ide) -mregexp -t'Nie widzisz zadnego wyjscia prowadzacego' _lazik_brak_wyjscia = \
    /mesg -w Nie ma takiego wyjscia, przerywam dzialanie lazika. %; \
    /_stop_lazik %; \

/def -F -aCgreen -E(_lazik_ide) -mregexp -t'Jestes tak zmeczony, ze nie mozesz dalej podazac w tym kierunku' _lazik_wyczerpanie = \
    /mesg -i Jestes zmeczony, odpoznij... %; \
    /_stop_lazik %; \

/def idz = \
    /if ({*} =~ NULL) \
        /mesg /idz [-e"komenda"] kierunek czas (musi byc float)%; \
        /mesg Czas nie musi byc podany, wtedy wynosi 0%; \
        /mesg Opcja -e jest opcjonalna, nie musi byc podawana %; \
        /return %; \
    /endif %; \
    /if (!getopts("e:", "")) /return 0 %; /endif %; \
    /if ({*} =~ "stop") \
        /mesg Przerywam dzialanie lazika.%; \
        /_stop_lazik %; \
        /return %; \
    /endif %; \
    /if ({*} =~ "next") \
	/lazik_next %; \
	/return %; \
    /endif %; \
    /_stop_lazik %; \
    /set _opcja_kom_lazika=%{opt_e}%;\
    /let _kier=%{1}%;\
    /if ({2} =~ NULL) \
        /set _lazik_czas=0%;\
    /else \
        /if ({2} > 0) \
            /set _lazik_czas=$[substr({2}, 0, strchr({2}, "."))] %; \
            /set _lazik_czas=%{_lazik_czas}.$[rand(0,99)] %; \
        /else \
            /set _lazik_czas=%{2}%;\
        /endif %; \
    /endif %; \
    /set _przeciwny=$(/znajdz_przeciwny %{_kier}) %; \
;    /echo %{_przeciwny}%; \
    /if (_przeciwny =~ "?") \
        /mesg -w Nie moge znalezc przeciwnego wyjscia! Przerywam dzialanie.%; \
        /_stop_lazik %; \
        /return %; \
    /endif %; \
    /set _lazik_ide=1%; \
    \
    /send %{_kier} %; \
    /if ({_opcja_kom_lazika} !/ null) \
        %{_opcja_kom_lazika} %; \
    /endif %; \
    /if (_lazik_tryb =~ "auto") \
        /echo %; \
        /if ({_opcja_kom_lazika} !/ null) \
            /mesg Ide na '%{_kier}' z delayem %{_lazik_czas} oraz wykonuje '%{_opcja_kom_lazika}' %;\
        /else \
            /mesg Ide na '%{_kier}' z delayem %{_lazik_czas} %; \
        /endif %; \
        /echo %; \
    /endif

/def znajdz_przeciwny = \
    /let _wyjscie=$[replace("polnoc", "n", \
                    replace("poludnie", "s", \
                    replace("wschod", "e", \
                    replace("zachod", "w", \
                    replace("polnocny-zachod", "nw", \
                    replace("polnocny-wschod", "ne", \
                    replace("poludniowy-zachod", "sw", \
                    replace("poludniowy-wschod", "se", \
                    replace("gora", "u", \
                    replace("dol", "d", {*}))))))))))] %; \
    /if     (_wyjscie =~ "n" )  /result "s" %; \
    /elseif (_wyjscie =~ "s" )  /result "n" %; \
    /elseif (_wyjscie =~ "e" )  /result "w" %; \
    /elseif (_wyjscie =~ "w" )  /result "e" %; \
    /elseif (_wyjscie =~ "se")  /result "nw"%; \
    /elseif (_wyjscie =~ "sw")  /result "ne"%; \
    /elseif (_wyjscie =~ "ne")  /result "sw"%; \
    /elseif (_wyjscie =~ "nw")  /result "se"%; \
    /elseif (_wyjscie =~ "u" )  /result "d" %; \
    /elseif (_wyjscie =~ "d" )  /result "u" %; \
    /else                       /result "?"%;\
    /endif

/def _idz = \
    /let _lazik_exits=$[replace("polnoc", "n", \
                        replace("poludnie", "s", \
                        replace("wschod", "e", \
                        replace("zachod", "w", \
                        replace("polnocny-zachod", "nw", \
                        replace("polnocny-wschod", "ne", \
                        replace("poludniowy-zachod", "sw", \
                        replace("poludniowy-wschod", "se", \
                        replace("gora", "u", \
                        replace("dol", "d", exits))))))))))] %; \
;    /echo ,,$[replace(" ", ",,", _lazik_exits)],, %; \
    /wyrzuc_przeciwny ,,$[replace(" ", ",,", _lazik_exits)],,

/def _lazik_exits_jedno = \
    /if ({#} > 1 | {#} < 1 | {*} =~ NULL) \
        /mesg -w Za duzo / malo wyjsc. Nie wiem co robic. %; \
        /_stop_lazik %; \
        /return %; \
    /endif %; \
;    /echo %{_lazik_exits} %; \
    /if (_lazik_tryb =~ "bind") \
        /if ({_opcja_kom_lazika} !/ null) \
            /%{_lazik_bind} /idz -e"%{_opcja_kom_lazika}" %{_lazik_exits} %; \
        /else \
            /%{_lazik_bind} /idz %{_lazik_exits} %; \
        /endif %; \
    /elseif (_lazik_tryb =~ "komenda") \
        /if ({_opcja_kom_lazika} !/ null) \
            /def lazik_next = /idz -e"%{_opcja_kom_lazika}" %{_lazik_exits} %; \
        /else \
            /def lazik_next = /idz %{_lazik_exits} %; \
        /endif %; \
    /else \
        /if ({_opcja_kom_lazika} !/ null) \
            /repeat -%{_lazik_czas} 1 /idz -e"%{_opcja_kom_lazika}" %{_lazik_exits} %{_lazik_czas} %; \
        /else \
            /repeat -%{_lazik_czas} 1 /idz %{_lazik_exits} %{_lazik_czas} %; \
        /endif %; \
    /endif %; \

/def wyrzuc_przeciwny = \
    /let _tmp=%{*}%; \
    /let _lazik_exits=%{_tmp}%; \
;    /echo Przed: %_lazik_exits%;\
    /let _lazik_exits=$[replace( strcat(",", _przeciwny, ","), "", _lazik_exits)] %; \
    /if (_tmp =~ _lazik_exits) \
        /mesg -w Cos nie tak, nie moglem usunac przeciwnego wyjscia, zatrzymuje lazika.%;\
        /_stop_lazik %; \
    /endif %; \
    /let _lazik_exits=$[replace(",,", " ", _lazik_exits)]%; \
;    /echo Po: %{_lazik_exits} %;\
    /_lazik_exits_jedno %{_lazik_exits}