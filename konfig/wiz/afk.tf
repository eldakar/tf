;
; Plik     : afk.tf
; Autor    : volus
; Poczatek : 22/07/2005, 00:46:49
; Koniec   : 22/07/2005, 04:08:23
; Opis     : Maszyna do afkowania korzystajaca z tickera ;]
;          : Zapisuje telle,
;
; Update   : 03/04/2006

/def update_afk = \
    /if ({afk} == 1) \
        /def -F -mregexp -t' tells you: ' _afk_tell = \
            /set zapis=%%{zapis}####$$[ftime("%%H:%%S")],%%{PL},$$[replace(" ", "___", replace(",", "|||", {PR}))]####%%; \
            /autoanswer %%{PL} %; \
        /repeat -1.5 1 /repeat -0.5 i /czy_juz_nie_afkuje %; \
        /def -F -ag -mregexp -t'^You tell' _afk_tell2%; \
    /else \
        /purge _afk_tel*%;\
        /pokaz_wiadomosci %{zapis}%;\
        /set zapis=%;\
        /kill $(/pid_of /czy_juz_nie_afkuje)%;\
    /endif

;; Ticker
/def ticker = \
    /if ({*} =~ "on") \
        /echo Ticker: on%;\
        /rstart -300 i wsay %;\
    /elseif ({*} =~ "off") \
        /echo Ticker: off%; \
        /rstop wsay %;\
    /else \
        /echo Usage: /ticker [on|off]%;\
    /endif

/set afk=0
/set zapis=

/def afk = \
    /if ({*} !~ "on" & {*} !~ "off") \
        /mesg /afk [on/off]?%; \
        /return%;\
    /endif %; \
    /if ({*} =~ "on") \
        /ticker on %; \
        /mesg Maszyna AFK wlaczona!%;\
        /set afk=1%;\
        /update_afk%; \
    /elseif ({*} =~ "off") \
        /ticker off %; \
        /mesg -i Maszyna AFK wylaczona!%;\
        /set afk=0%; \
        /update_afk%; \
    /endif

/def sprawdz_afk = \
    /let _liczba=$[rand(60, 180)] %; \
    /let _sidle=$[sidle()]%;\
    /if ({_sidle} > 600) \
        /if ({afk} == 0) \
            /afk on%; \
        /endif %; \
        /repeat -%{_liczba} 1 /sprawdz_afk %; \
    /else \
        /repeat -%{_liczba} 1 /sprawdz_afk %; \
    /endif


/rstop /sprawdz_afk
/sprawdz_afk

/def czy_juz_nie_afkuje = \
    /let _idl=$[idle()]%;\
    /if ({_idl} < 1) \
        /afk off%;\
    /endif

/def autoanswer = \
    /if ({*} !~ NULL) \
;        /repeat -2 1 tell %{*} Wybacz, teraz mnie nie ma przy komputerze, ale jak wroce, to na pewno odpisze.%;\
    /endif

/def pokaz_wiadomosci = \
    /if ({zapis} =~ NULL) \
        /mesg -w Nie dostales zadnych wiadomosci.%; \
    /else \
        /let _st=$[replace("####", " ", {*})]%;\
        /policz_dane %{_st}%;\
        /podziel_dane %{_st}%;\
    /endif

/def policz_dane =\
    /let _int=0%;\
    /while ({#}) \
        /test ++_int%;\
        /shift%;\
    /done%;\
    /if ({_int} == 1) \
        /let _cos=wiadomosc%;\
    /else \
        /let _cos=wiadomosci%;\
    /endif%;\
    /mesg -w Masz %{_int} %{_cos}.

/def podziel_dane = \
    /while ({#}) \
        /podziel_dane2 $[replace(",", " ", {*})]%;\
        /shift%;\
    /done

/def podziel_dane2 = \
    /let __d=%{1}%;\
    /let __i=%{2}%;\
    /let __s=$[replace("___", " ", replace("|||", ",", {3}))]%;\
    /mesg -i O godzinie %{__d}, od %{__i}: %{__s}
