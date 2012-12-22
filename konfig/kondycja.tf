;
; Plik  : kondycja.tf
; Autor : volus
; Data  : 11/03/2006, 21:46:01
; Opis  : Kondycja :)
;

/def kondycja_toggle = \
    /if (!_kondycja_org) \
        /mesg Pokazuje kondycje z napisem. %; \
        /set _kondycja_org=1%;\
    /else \
        /mesg Pokazuje kondycje bez napisu. %; \
        /set _kondycja_org=0%;\
    /endif

/set _kondycja_org=1

/def -F -mregexp -t'^Jestes (w (swietnej kondycji|dobrym stanie|zlej kondycji)|(lekko |ciezko |)rann.|ledwo zyw.)\.$' _kondycja_catch = \
    /set lap_kondycje_innych=1 %; \
    /set _numer_kondycja_last_id=1 %; \
    /repeat -0.1 1 /unset lap_kondycje_innych%; \
    /if ({P1} =~ "w swietnej kondycji") \
        /let _k=7%; \
        /let _kol=BCgreen%; \
    /elseif ({P1} =~ "w dobrym stanie") \
        /let _k=6%; \
        /let _kol=BCgreen%; \
    /elseif ({P1} =/ "lekko rann?") \
        /let _k=5%; \
        /let _kol=Cgreen%; \
    /elseif ({P1} =/ "rann?") \
        /let _k=4%; \
        /let _kol=Cyellow%; \
    /elseif ({P1} =~ "w zlej kondycji") \
        /let _k=3%; \
        /let _kol=BCmagenta%; \
    /elseif ({P1} =/ "ciezko rann?") \
        /let _k=2%; \
        /let _kol=Cred%; \
    /elseif ({P1} =/ "ledwo zyw?") \
        /let _k=1%; \
        /let _kol=BCred%; \
    /else \
        /let _k=0%; \
        /let _kol=h%; \
    /endif %; \
    /set _kondycja_ja=%{_k} %; \
    /if (_kondycja_org) \
        /substitute -p [Ja ]@{nBCyellow}|@{n%_kol}$[strrep("##", _k)]@{nBCyellow}$[strrep("  ", 7 - _k)]|@{nBCwhite} -[Ja] $[pad("Ja", -40, strcat("@{n", _kol, "}"), 0, {P1}, -20)]%; \
    /else \
        /substitute -p [Ja ]@{nBCyellow}|@{n%_kol}$[strrep("##", _k)]@{nBCyellow}$[strrep("  ", 7 - _k)]|@{nBCwhite} -[Ja] Ja.@{n} %; \
    /endif

/def testuj = \
    /itrigger Jestes w swietnej kondycji. %; \
    /itrigger Jestes w dobrym stanie. %; \
    /itrigger Jestes lekko ranny. %; \
    /itrigger Jestes ranny. %; \
    /itrigger Jestes w zlej kondycji. %; \
    /itrigger Jestes ciezko ranny. %; \
    /itrigger Jestes ledwo zywy.%; \
    /itrigger Daggerro jest w swietnej kondycji. %; \
    /itrigger Bagrum jest w dobrym stanie. %; \
    /itrigger Sjorving jest lekko ranny. %; \
    /itrigger Male chude dziecko jest ranne. %; \
    /itrigger Stary lysy dziadek jest w zlej kondycji. %; \
    /itrigger Lori jest ciezko ranna. %; \
    /itrigger Mala piersiasta kobieta jest ledwo zywa.

/def -E(lap_kondycje_innych) -Fp1000 -mregexp -t' jest (w (swietnej kondycji|dobrym stanie|zlej kondycji)|(lekko |ciezko |)rann.|ledwo zyw.)\.$' _kondycja_catch2 = \
    /if ({P1} =~ "w swietnej kondycji") \
        /let _k=7%; \
        /let _kol=BCgreen%; \
    /elseif ({P1} =~ "w dobrym stanie") \
        /let _k=6%; \
        /let _kol=BCgreen%; \
    /elseif ({P1} =/ "lekko rann?") \
        /let _k=5%; \
        /let _kol=Cgreen%; \
    /elseif ({P1} =/ "rann?") \
        /let _k=4%; \
        /let _kol=Cyellow%; \
    /elseif ({P1} =~ "w zlej kondycji") \
        /let _k=3%; \
        /let _kol=BCmagenta%; \
    /elseif ({P1} =/ "ciezko rann?") \
        /let _k=2%; \
        /let _kol=Cred%; \
    /elseif ({P1} =/ "ledwo zyw?") \
        /let _k=1%; \
        /let _kol=BCred%; \
    /else \
        /let _k=0%; \
        /let _kol=h%; \
    /endif %; \
    /let _who=$[replace("(", "", replace(")", "", replace("[", "", replace("]", "", {PL}))))]%; \
    /sprawdz_odmiane $[tolower(_who)]%; \
    /if (tolower(_who) =~ druzyna_leader) \
        /let _dl=$[decode_attr("@{Cyellow}L@{n}")]%;\
    /elseif (druzyna_grupa !/ "") \
        /if (tolower(replace(" ", "_", _who)) =/ strcat("*{", druzyna_grupa, "}*")) \
            /let _dl=$[decode_attr("@{BCmagenta}D@{n}")]%;\
        /else \
	        /let _dl=$[strrep(" ", 1)]%; \
	    /endif %; \
    /else \
        /let _dl=$[strrep(" ", 1)]%;\
    /endif %;\
    /set _kondycja_osoba_%{_numer_kondycja_last_id}=$[tolower(_who)] %; \
    /if (_kondycja_org) \
        /substitute -p [$[pad(_numer_kondycja_last_id, -2)]%{_dl}]@{nBCyellow}|@{n%_kol}$[strrep("##", _k)]@{nBCyellow}$[strrep("  ", 7 - _k)]|@{nBCwhite} -[$[pad(_numer_kondycja_last_id, -2)]] $[pad({PL}, -40, strcat("@{n", _kol, "}"), 0, {P1}, -20)]%; \
    /else \
        /substitute -p [$[pad(_numer_kondycja_last_id, -2)]%{_dl}]@{nBCyellow}|@{n%_kol}$[strrep("##", _k)]@{nBCyellow}$[strrep("  ", 7 - _k)]|@{nBCwhite} -[$[pad(_numer_kondycja_last_id, -2)]] %{PL}.@{n}%; \
    /endif %; \
    /test ++_numer_kondycja_last_id

/def ob = \
    /if ({1} =~ NULL) \
        /if (_numer_kondycja_last_id > 1) \
            /mesg -i Musisz podac argument w postaci liczby od 1 do $[_numer_kondycja_last_id - 1] %; \
            /return %; \
        /else \
            /mesg -i Nie zostala ustawiona zadna inna osoba, wiec /ob nie dziala. %; \
            /return %; \
        /endif %; \
    /endif %; \
    /if (_numer_kondycja_last_id <= {1}) \
        /mesg -w Pod numerem %{1} nie jest przypisana zadna osoba.%; \
        /return %; \
    /endif %; \
    /let _kto=$(/eval /echo %%{_kondycja_osoba_%1}) %; \
    /mesg ogladamy: $(/m_bie %{_kto}) %; \
    /send ob $(/m_bie %{_kto})

; zeby bylo prosciej
/alias qq /ob %{1}

;; mowienie do danej osoby tez dam ;]
/def mow = \
    /if ({1} =~ NULL) \
        /if (_numer_kondycja_last_id > 1) \
            /mesg -i Musisz podac argument w postaci liczby od 1 do $[_numer_kondycja_last_id - 1] %; \
            /return %; \
        /else \
            /mesg -i Nie zostala ustawiona zadna inna osoba, wiec /mow nie dziala. %; \
            /return %; \
        /endif %; \
    /endif %; \
    /if (_numer_kondycja_last_id <= {1}) \
        /mesg -w Pod numerem %{1} nie jest przypisana zadna osoba.%; \
        /return %; \
    /endif %; \
    /let _kto=$(/eval /echo %%{_kondycja_osoba_%1}) %; \
    /send powiedz do $(/m_dop %{_kto}) %{-1}

;; zabijanie, a co! ;]
/def z = \
    /if ({1} =~ NULL) \
        /if (_numer_kondycja_last_id > 1) \
            /mesg -i Musisz podac argument w postaci liczby od 1 do $[_numer_kondycja_last_id - 1] %; \
            /return %; \
        /else \
            /mesg -i Nie zostala ustawiona zadna inna osoba, wiec /z nie dziala. %; \
            /return %; \
        /endif %; \
    /endif %; \
    /if (_numer_kondycja_last_id <= {1}) \
        /mesg -w Pod numerem %{1} nie jest przypisana zadna osoba.%; \
        /return %; \
    /endif %; \
    /let _kto=$(/eval /echo %%{_kondycja_osoba_%1}) %; \
    /mesg zabijam: $(/m_bie %{_kto}) %; \
    /send zabij $(/m_bie %{_kto})

;; zaslanianie
;; uzycie: /zas 2 3 <- kogo przed kim
/def zas = \
    /if ({2} =~ NULL) \
        /if (_numer_kondycja_last_id > 1) \
    	    /let _kogo=$(/eval /echo %%{_kondycja_osoba_%1}) %; \
    	    /mesg zaslaniam %_kogo %; \
    	    /send zaslon $(/m_bie %{_kogo}) %; \
    	    /return %; \
        /else \
            /mesg -i Nie zostala ustawiona zadna inna osoba, wiec /zas nie dziala. %; \
            /return %; \
        /endif %; \
    /endif %; \
    /if (_numer_kondycja_last_id <= {1}) \
        /mesg -w Pod numerem %{1} nie jest przypisana zadna osoba.%; \
        /return %; \
    /endif %; \
    /if (_numer_kondycja_last_id <= {2}) \
        /mesg -w Pod numerem %{2} nie jest przypisana zadna osoba.%; \
        /return %; \
    /endif %; \
    /let _kogo=$(/eval /echo %%{_kondycja_osoba_%1}) %; \
    /let _przed=$(/eval /echo %%{_kondycja_osoba_%2})%; \
    /mesg zaslaniam: $(/m_bie %{_kogo}) przed $(/m_nar %{_przed}) %; \
    /send zaslon $(/m_bie %{_kogo}) przed $(/m_nar %{_przed})


;; przedstawianie sie osobie
/def pss = \
    /if ({1} =~ NULL) \
        /if (_numer_kondycja_last_id > 1) \
            /mesg -i Musisz podac argument w postaci liczby od 1 do $[_numer_kondycja_last_id - 1] %; \
            /return %; \
        /else \
            /mesg -i Nie zostala ustawiona zadna inna osoba, wiec /pss nie dziala. %; \
            /return %; \
        /endif %; \
    /endif %; \
    /if (_numer_kondycja_last_id <= {1}) \
        /mesg -w Pod numerem %{1} nie jest przypisana zadna osoba.%; \
        /return %; \
    /endif %; \
    /let _kto=$(/eval /echo %%{_kondycja_osoba_%1}) %; \
    /mesg Przedstawiamy sie $(/m_cel %{_kto}) %; \
    /send przedstaw sie $(/m_cel %{_kto})

;; rozkazywanie zaslaniania
;; uzycie:
;; /roz     - rozkaz druzynie zaslonic ciebie
;; /roz 1   - rozkaz druzynie zaslonic 1
;; /roz 1 0 - rozkaz 1 zaslonic ciebie
;; /roz 1 2 - rozkaz 1 zaslonic 2
/def roz = \
    /if ({1} =~ NULL) \
        /mesg rozkaz druzynie zaslonic ciebie %; \
        /send rozkaz druzynie zaslonic ciebie %; \
        /return %; \
    /endif %; \
    /if ({2} =~ NULL) \
        /let _kogo=$(/eval /echo %%{_kondycja_osoba_%1}) %; \
        /mesg rozkaz druzynie zaslonic $(/m_bie %{_kogo}) %; \
        /send rozkaz druzynie zaslonic $(/m_bie %{_kogo}) %; \
        /return %; \
    /endif %; \
    /if (_numer_kondycja_last_id <= {1}) \
        /mesg -w Pod numerem %{1} nie jest przypisana zadna osoba.%; \
        /return %; \
    /endif %; \
    /if ({2} == 0) \
        /let _kto=$(/eval /echo %%{_kondycja_osoba_%1}) %; \
        /mesg rozkaz $(/m_cel %{_kto}) zaslonic ciebie %; \
        /send rozkaz $(/m_cel %{_kto}) zaslonic ciebie %; \
        /return %; \
    /endif %; \
    /if (_numer_kondycja_last_id <= {2}) \
        /mesg -w Pod numerem %{2} nie jest przypisana zadna osoba.%; \
        /return %; \
    /endif %; \
    /let _kogo=$(/eval /echo %%{_kondycja_osoba_%1}) %; \
    /let _przed=$(/eval /echo %%{_kondycja_osoba_%2})%; \
    /mesg rozkazuje $(/m_cel %{_kogo}) zaslonic $(/m_bie %{_przed}) %; \
    /send rozkaz $(/m_cel %{_kogo}) zaslonic $(/m_bie %{_przed})


;; rozkazywanie ataku
;; uzycie:
;; /roa 1   - rozkaz druzynie zaatakowac 1
/def roa = \
    /if ({1} =~ NULL) \
        /mesg Uzycie: /roa 1 - gdzie 1 to liczba osoby przypisanej z kondycji wszystkich %; \
        /return %; \
    /endif %; \
    /if (_numer_kondycja_last_id <= {1}) \
        /mesg -w Pod numerem %{1} nie jest przypisana zadna osoba.%; \
        /return %; \
    /endif %; \
    /let _kto=$(/eval /echo %%{_kondycja_osoba_%1}) %; \
    /mesg rozkazuje druzynie zaatakowac $(/m_bie %{_kto}) %; \
    /send rozkaz druzynie zaatakowac $(/m_bie %{_kto})
