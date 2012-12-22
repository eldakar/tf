;
; Plik     : odmiana.tf
; Autor    : volus
; Poczatek : 15/09/2005, 23:18:11
; Koniec   :
; Opis     : Skrypt odmiany, dodajacy odmienione rzeczy do bazy odmiany
;            Wykorzystujacy lib arrayow, napisana przeze mnie.
;            Oraz kilka rozwiazan Ingwara
;

/if ($(/list mesg) =~ NULL) \
    /def mesg = \
        /if (!getopts("iw", "")) /return 0%%; /endif %%; \
        /if ({opt_i}) \
            /test echo(strcat("@{BCgreen}####@{n}", " @{Cyellow}", {*}), "", 1) %%; \
        /elseif ({opt_w}) \
            /test echo(strcat("@{BCgreen}####@{n}", " @{BCred}", {*}), "", 1) %%; \
        /else \
            /test echo(strcat("@{BCgreen}####@{n}", " ", {*}), "", 1) %%; \
        /endif %; \
/endif


/if ($(/listvar biblioteka_tablic_wersja) =~ NULL) \
    /mesg -w Nie posiadasz biblioteki tablic volusa wersji przynajmniej 1.0!%; \
    /mesg -w Biblioteka ta jest niezbedna do dzialania tego skryptu!%; \
/endif


/set czy_dodac_odmiane=0
/set _nieodmienne_przymiotniki=|bardzo|wody|ognia|ziemi|powietrza|chaosu|dobrze|poczty|biologii|

; Nieodmienialne - bardzo, wody, ognia, ziemi, powietrza, chaosu
; bardzo maly zywiolak wody chaosu
; bardzo malego zywiolaka wody chaosu

; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
; Tutaj ustawiamy plik w ktorym beda przechowywane odmiany
/eval /set baza_odmiany=%{DBDIR}/baza_odmian.db

/def check_odmiana_index = \
    /if ({2} =~ "dop")     \
        /let _o=2%; \
    /elseif ({2} =~ "cel") \
        /let _o=3%; \
    /elseif ({2} =~ "bie") \
        /let _o=4%; \
    /elseif ({2} =~ "nar") \
        /let _o=5%; \
    /elseif ({2} =~ "mie") \
        /let _o=6%; \
    /else \
        /let _o=0%; \
    /endif %; \
    /check_index odmiana_%{1} %{_o}

; Funkcja odmien ZAWSZE pobiera informacje z bazy odmiany
/def _odmien = \
    /echo Odmieniam (kto/co)            : %{*} %; \
    /echo Dopelniacz (nie ma kogo/czego): $(/m_dop %{*}) %; \
    /echo Celownik (komu/czemu)         : $(/m_cel %{*}) %; \
    /echo Biernik (zaslon kogo/co)      : $(/m_bie %{*}) %; \
    /echo Narzednik (przed kim/czym)    : $(/m_nar %{*}) %; \
    /echo Miejscownik (o kim/czym)      : $(/m_mie %{*})


; dodalem mozliwosc odmieniania niezytownych rzeczy, jak np. wszelakie bronie
; dla przykladu jak chcemy wyciagnac z plecaka miecz, to przymiotniki zle odmienialy zawsze w bierniku
; nowe funkcje umozliwiaja poprawna odmiane; update: 31 05 2006 - na prosbe Sjorvinga :)
/def _odmien_n = \
    /echo Odmieniam (kto/co)            : %{*} %; \
    /echo Dopelniacz (nie ma kogo/czego): $(/m_dop_n %{*}) %; \
    /echo Celownik (komu/czemu)         : $(/m_cel_n %{*}) %; \
    /echo Biernik (masz przy sobie)     : $(/m_bie_n %{*}) %; \
    /echo Narzednik (przed kim/czym)    : $(/m_nar_n %{*}) %; \
    /echo Miejscownik (o kim/czym)      : $(/m_mie_n %{*})

/def odmien = \
    /if ({#} < 1) \
        /echo Musisz podac co chcesz odmienic. %; \
        /echo Np. /odmien elf %; \
        /return %; \
    /endif %; \
    /if (strstr(_nieodmienne_przymiotniki, strcat("|", {L}, "|")) > -1) \
        /if (if_array_exists(strcat("odmiana_", tolower({L2})))) \
            /_odmien %{*} %; \
        /else \
            /echo -p @{BCwhite}Nie mam odmiany @{nBCcyan}$[tolower({L2})]@{nBCwhite}! Wcisnij @{nBCgreen}F10@{nBCwhite} by dodac. %; \
            /set czy_dodac_odmiane=1%; \
            /f10 -q /dodaj_odmiane $[tolower({L2})]%; \
        /endif %; \
    /else \
        /if (if_array_exists(strcat("odmiana_", tolower({L})))) \
            /_odmien %{*} %; \
        /else \
            /echo -p @{BCwhite}Nie mam odmiany @{nBCcyan}$[tolower({L})]@{nBCwhite}! Wcisnij @{nBCgreen}F10@{nBCwhite} by dodac. %; \
            /set czy_dodac_odmiane=1%; \
            /f10 -q /dodaj_odmiane $[tolower({L})]%; \
        /endif %; \
    /endif

; dodaje mozliwosc odmiany meskiego niezytownego, zeby sie przydalo do broni
/set _nieodmienne_przymiotniki_n=|dwureczny|

/def odmien_n = \
    /if ({#} < 1) \
        /echo Musisz podac co chcesz odmienic. %; \
        /echo Np. /odmien_n duzy miecz %; \
        /return %; \
    /endif %; \
    /if (strstr(_nieodmienne_przymiotniki_n, strcat("|", {L}, "|")) > -1) \
        /if (if_array_exists(strcat("odmiana_", tolower({L2})))) \
            /_odmien_n %{*} %; \
        /else \
            /echo -p @{BCwhite}Nie mam odmiany @{nBCcyan}$[tolower({L2})]@{nBCwhite}! Wcisnij @{nBCgreen}F10@{nBCwhite} by dodac. %; \
            /set czy_dodac_odmiane=1%; \
            /f10 /dodaj_odmiane $[tolower({L2})]%; \
        /endif %; \
    /else \
        /if (if_array_exists(strcat("odmiana_", tolower({L})))) \
            /_odmien_n %{*} %; \
        /else \
            /echo -p @{BCwhite}Nie mam odmiany @{nBCcyan}$[tolower({L})]@{nBCwhite}! Wcisnij @{nBCgreen}F10@{nBCwhite} by dodac. %; \
            /set czy_dodac_odmiane=1%; \
            /f10 /dodaj_odmiane $[tolower({L})]%; \
        /endif %; \
    /endif

/def if_string_has_two_words = \
    /if ({#} == 2) \
        /result 1%; \
    /endif

/def podziel_odmiane = \
    /if (strstr(_nieodmienne_przymiotniki, strcat("|", {3}, "|")) > -1) \
        /if ($(/if_string_has_two_words $[strcat({2}, " ", {3})]) == 0) \
            /let _temp_nieodm=%{3}%; \
            /if ({4} != 1) \
                /let _l=$[replace(' ', '', substr({L2}, strrchr({L2}, ' ')))]%; \
                /let _l2=$[replace({_l}, '', replace({_temp_nieodm}, '', {L2}))]%; \
            /else \
                /let _l=$[replace(' ', '', substr({L3}, strrchr({L3}, ' ')))]%; \
                /let _l2=$[replace({_l}, '', replace({_temp_nieodm}, '', {L3}))]%; \
            /endif %; \
            /if ({4} != 1) \
                /test podziel_odmiane({1}, {_l2}, {_l}) %; \
            /else \
                /test podziel_odmiane({1}, {_l2}, {_l}, 1)%; \
            /endif %; \
            /return %; \
        /else \
            /let _temp_nieodm=%{3}%; \
            /if ({4} != 1) \
                /test podziel_odmiane({1}, "", {L2}) %; \
            /else \
                /test podziel_odmiane({1}, "", {L3}, 1) %; \
            /endif %; \
            /return %; \
        /endif %; \
    /endif %; \
    /if (!if_array_exists(strcat("odmiana_", tolower({3})))) \
        /echo -p @{BCwhite}Nie mam odmiany @{nBCcyan}$[tolower({3})]@{nBCwhite}! Wcisnij @{nBCgreen}F10@{nBCwhite} by dodac. %; \
        /set czy_dodac_odmiane=1%; \
        /f10 -q /dodaj_odmiane $[tolower({3})]%; \
        /return %; \
    /endif %; \
    /if ({2} !~ NULL) \
        /if ({4} != 1) \
            /let odmiana=$(/odmien_m_%{1} %{2})%; \
            /let odmiana=$[strcat({odmiana}, ' ')]%; \
        /endif %; \
    /endif %; \
    /if ({4} != 1) \
        /echo %{odmiana}$(/check_odmiana_index %{3} %{1}) %{_temp_nieodm} %; \
    /endif

/def podziel_odmiane_n = \
    /if (strstr(_nieodmienne_przymiotniki_n, strcat("|", {3}, "|")) > -1) \
        /if ($(/if_string_has_two_words $[strcat({2}, " ", {3})]) == 0) \
            /let _temp_nieodm=%{3}%; \
            /if ({4} != 1) \
                /let _l=$[replace(' ', '', substr({L2}, strrchr({L2}, ' ')))]%; \
                /let _l2=$[replace({_l}, '', replace({_temp_nieodm}, '', {L2}))]%; \
            /else \
                /let _l=$[replace(' ', '', substr({L3}, strrchr({L3}, ' ')))]%; \
                /let _l2=$[replace({_l}, '', replace({_temp_nieodm}, '', {L3}))]%; \
            /endif %; \
            /if ({4} != 1) \
                /test podziel_odmiane_n({1}, {_l2}, {_l}) %; \
            /else \
                /test podziel_odmiane_n({1}, {_l2}, {_l}, 1)%; \
            /endif %; \
            /return %; \
        /else \
            /let _temp_nieodm=%{3}%; \
            /if ({4} != 1) \
                /test podziel_odmiane_n({1}, "", {L2}) %; \
            /else \
                /test podziel_odmiane_n({1}, "", {L3}, 1) %; \
            /endif %; \
            /return %; \
        /endif %; \
    /endif %; \
    /if (!if_array_exists(strcat("odmiana_", tolower({3})))) \
        /echo -p @{BCwhite}Nie mam odmiany @{nBCcyan}$[tolower({3})]@{nBCwhite}! Wcisnij @{nBCgreen}F10@{nBCwhite} by dodac. %; \
        /set czy_dodac_odmiane=1%; \
        /f10 -q /dodaj_odmiane $[tolower({3})]%; \
        /return %; \
    /endif %; \
    /if ({2} !~ NULL) \
        /if ({4} != 1) \
            /let odmiana=$(/odmien_m_%{1}_n %{2})%; \
            /let odmiana=$[strcat({odmiana}, ' ')]%; \
        /endif %; \
    /endif %; \
    /if ({4} != 1) \
        /echo %{odmiana}$(/check_odmiana_index %{3} %{1}) %{_temp_nieodm} %; \
    /endif

;/def m_dop = /echo $(/check_odmiana_index %{1} 2)
/def m_dop = /test podziel_odmiane("dop", {-L}, {L})
/def m_cel = /test podziel_odmiane("cel", {-L}, {L})
/def m_bie = /test podziel_odmiane("bie", {-L}, {L})
/def m_nar = /test podziel_odmiane("nar", {-L}, {L})
/def m_mie = /test podziel_odmiane("mie", {-L}, {L})

/def m_dop_n = /test podziel_odmiane_n("dop", {-L}, {L})
/def m_cel_n = /test podziel_odmiane_n("cel", {-L}, {L})
/def m_bie_n = /test podziel_odmiane_n("bie", {-L}, {L})
/def m_nar_n = /test podziel_odmiane_n("nar", {-L}, {L})
/def m_mie_n = /test podziel_odmiane_n("mie", {-L}, {L})

;; odmienia narzednik -> mianownik
/def narzednik_mianownik = \
    /if (substr({2}, -3, 3) =~ "iem") \
        /let _licz=-3%; \
    /elseif (substr({2}, -2, 2) =~ "em") \
        /let _licz=-2%; \
    /else \
        /let _licz=$[strlen({2})]%; \
    /endif %; \
; wyjatki
    /if ({2} =~ "psem") \
        /test narzednik_mianownik({1}, "pies") %; \
        /return %; \
    /elseif ({2} =~ "kupcem") \
        /test narzednik_mianownik({1}, "kupiec") %; \
        /return %; \
    /elseif ({2} =~ "renem") \
	/test narzednik_mianownik({1}, "reno") %; \
	/return %; \
    /endif %; \
; koniec wyjatkow
    /if (!if_array_exists(strcat("odmiana_", tolower(substr({2}, 0, _licz))))) \
        /echo -p @{BCwhite}Nie mam odmiany @{nBCcyan}$[tolower({2})]@{nBCwhite}! Wcisnij @{nBCgreen}F10@{nBCwhite} by dodac. %; \
        /set czy_dodac_odmiane=1%; \
        /f10 -q /dodaj_odmiane $[tolower({2})]%; \
        /return %; \
    /endif %; \
    /if ({1} !~ NULL) \
        /let odmiana=$(/odmien_n_m %{1}) %; \
        /let odmiana=$[strcat({odmiana}, ' ')]%; \
    /endif %; \
    /echo %{odmiana}$[substr({2}, 0, _licz)] %{_temp_nieodm}

/def n_mia = /test narzednik_mianownik({-L}, {L})

/def odmien_n_m = \
    /while ({#}) \
        /let _lit1=$[substr({1}, -1, 1)]%; \
        /let _lit2=$[substr({1}, -2, 2)]%; \
        /if (_sprawdz_nieodmienne({1})) \
            /let _return=$[strcat(_return, {1}, ' ')] %; \
            /shift %; \
        /else \
            /if     (_2_litera("ym")) \
                /let _ret=$[strcat(substr({1}, 0, -2), 'y')]%; \
            /elseif (_1_litera("m"))    /let _ret=$[strcat(substr({1}, 0, -2), 'i')]%; \
            /elseif (_1_litera("a"))    /let _ret=%{1}%; \
            /else                       /let _ret=$[strcat({1}, 0, -2)]%; \
            /endif %; \
            /let _return=$[strcat(_return, _ret, ' ')] %; \
            /shift %; \
        /endif %; \
    /done %; \
    /echo $[tolower(_return)]

;; Funkcja dodana 12/03/2006
;; Sprawdza czy odmiana istnieje. Jesli tak, nie zwraca nic, jesli nie
;; Otrzymujemy komunikat ze nie ma odmiany i binduje /f10 zeby ja zapisac
/def sprawdz_odmiane = /test podziel_odmiane("dop", {-L}, {L}, 1)

/def dodaj_odmiane = \
    /if ({czy_dodac_odmiane}) \
        /gagi_na_odmiane %{*}%; \
    /endif %; \
    odmien %{*}

/def gagi_na_odmiane = \
    /def -ag -mregexp -t'odmienia sie nastepujaco:'  _dodanie_odmiany_0 = \
        /def -ag -p500 -mregexp -t'Mianownik: (.*),$$$'    _dodanie_odmiany_1 = /set _mia=$$$[tolower(replace(",", "", {L}))] %%; \
        /def -ag -p500 -mregexp -t'Dopelniacz: (.*),$$$'   _dodanie_odmiany_2 = /set _dop=$$$[tolower(replace(",", "", {L}))] %%; \
        /def -ag -p500 -mregexp -t'Celownik: (.*),$$$'     _dodanie_odmiany_3 = /set _cel=$$$[tolower(replace(",", "", {L}))] %%; \
        /def -ag -p500 -mregexp -t'Biernik: (.*),$$$'      _dodanie_odmiany_4 = /set _bie=$$$[tolower(replace(",", "", {L}))] %%; \
        /def -ag -p500 -mregexp -t'Narzednik: (.*),$$$'    _dodanie_odmiany_5 = /set _nar=$$$[tolower(replace(",", "", {L}))] %%; \
        /def -ag -p500 -mregexp -t'Miejscownik: (.*)\.$$$' _dodanie_odmiany_6 = /set _mie=$$$[tolower(replace(".", "", {L}))] %%%; \
            /echo -p @{Cgreen}Dopisuje odmiane @{B}%%%{_mia}@{nCgreen} do bazy odmian... %%%; \
            /rdodaj %%%{_mia} %%%{_dop} %%%{_cel} %%%{_bie} %%%{_nar} %%%{_mie} %%%; \
            /set czy_dodac_odmiane=0 %%%; \
            /purge _dodanie_odmiany_* %; \
    /def -mregexp -t'Odmien <kto/co>\?'              _dodanie_odmiany_7 = \
        /echo -p @{Cgreen}Nie ma danej osoby, badz przedmiotu na lokacji (@{nBCwhite}%{*}@{nCgreen})%%; \
        /set czy_dodac_odmiane=0%%; \
        /purge _dodanie_odmiany_*

/def rdodaj = \
    /if ({#} < 6) \
        /echo Jezyk polski ma 6 przypadkow... %; \
        /return %; \
    /endif %; \
    /if (!if_array_exists(strcat("odmiana_", {1}))) \
        /add_array odmiana_%{1} %{1} %{2} %{3} %{4} %{5} %{6}%; \
        /zapisz_odmiane %{1} %; \
        /echo Odmiana '%{1}' zapisana do pliku '%{baza_odmiany}'%; \
    /else \
        /echo Odmiana '%{1}' juz jest zapisana w bazie. %; \
    /endif

/def zapisz_odmiane = \
    /let _PZ=$(/eval /echo %%_array_odmiana_%{1}) %; \
    /test fwrite(baza_odmiany, '_array_odmiana_%{1}=%{_PZ}')

/def odczytaj_odmiany = \
    /quote -S /unset `/listvar -s _array_odmiana_*%; \
    /quote -S /set '%{baza_odmiany} %; \
    /echo -p @{BCwhite}Wczytalem @{nBCgreen}$(/length $(/quote -S /first `/listvar _array_odmiana_*))@{nBCwhite} odmian.

/odczytaj_odmiany

/def baza = \
    /echo -p @{BCwhite}Baza posiada @{nBCgreen}$(/length $(/quote -S /first `/listvar _array_odmiana_*))@{nBCwhite} odmian.





;;;; Funkcje odpowiadajace za odmienianie przymiotnikow przez przypadki
;;;; I tylko przymiotnikow :) Rasy, itemy i imiona sa wyzej
;;;; Oczywiscie nie zmieniac :PPPP


;¤=> /odmien bardzo stary duzy elf chaosu
;Odmieniam (kto/co)            : bardzo stary duzy elf chaosu
;Dopelniacz (nie ma kogo/czego): bardzo starego duzego elfa chaosu
;Celownik (komu/czemu)         : bardzo staremu duzemu duzemu chaosu
;Biernik (zaslon kogo/co)      : bardzo starego duzego elfa chaosu
;Narzednik (przed kim/czym)    : bardzo starym duzym elfem chaosu
;Miejscownik (o kim/czym)      : bardzo starym duzym duzym chaosu
;
; Do poprawy :/
;
; 2005 09 30 - okolo polnocy - juz dziala :D

/def _1_litera = \
    /if (_lit1 =~ {*}) \
        /return 1%; \
    /endif

/def _2_litera = \
    /if (_lit2 =~ {*}) \
        /return 1%; \
    /endif

/def _sprawdz_nieodmienne = \
    /if (regmatch(strcat("\|", {1}, "\|"), {_nieodmienne_przymiotniki})) \
        /return 1%; \
    /endif

/def _sprawdz_nieodmienne_n = \
    /if (regmatch(strcat("\|", {1}, "\|"), {_nieodmienne_przymiotniki_n})) \
        /return 1%; \
    /endif

/def odmien_m_dop = \
    /while ({#}) \
        /let _lit1=$[substr({1}, -1, 1)]%; \
        /let _lit2=$[substr({1}, -2, 2)]%; \
        /if (_sprawdz_nieodmienne({1})) \
            /let _return=$[strcat(_return, {1}, ' ')] %; \
            /shift %; \
        /else \
            /if     (_2_litera("ka") | _2_litera("ga"))   /let _ret=$[strcat(substr({1}, 0, -1), 'iej')]%; \
            /elseif (_1_litera("y"))    /let _ret=$[strcat(substr({1}, 0, -1), 'ego')]%; \
            /elseif (_1_litera("i"))    /let _ret=$[strcat({1}, 'ego')]%; \
            /elseif (_1_litera("a"))    /let _ret=$[strcat(substr({1}, 0, -1), 'ej')]%; \
            /else                       /let _ret=$[strcat({1}, 'a')]%; \
            /endif %; \
            /let _return=$[strcat(_return, _ret, ' ')]%; \
            /shift %; \
        /endif %; \
    /done %; \
    /echo $[tolower(_return)]

/def odmien_m_cel = \
    /while ({#}) \
        /let _lit1=$[substr({1}, -1, 1)]%; \
        /let _lit2=$[substr({1}, -2, 2)]%; \
        /if (_sprawdz_nieodmienne({1})) \
            /let _return=$[strcat(_return, {1}, ' ')] %; \
            /shift %; \
        /else \
            /if     (_1_litera("i"))    /let _ret=$[strcat({1}, 'emu')]%; \
            /elseif (_2_litera("ka") | _2_litera("ga"))   /let _ret=$[strcat(substr({1}, 0, -1), 'iej')]%; \
            /elseif (_1_litera("y"))    /let _ret=$[strcat(substr({1}, 0, -1), 'emu')]%; \
            /elseif (_1_litera("a"))    /let _ret=$[strcat(substr({1}, 0, -1), 'ej')]%; \
            /else                       /let _ret=$[strcat({1}, 'owi')]%; \
            /endif %; \
            /let _return=$[strcat(_return, _ret, ' ')] %; \
            /shift %; \
        /endif %; \
    /done %; \
    /echo $[tolower(_return)]

/def odmien_m_bie = \
    /while ({#}) \
        /let _lit1=$[substr({1}, -1, 1)]%; \
        /let _lit2=$[substr({1}, -2, 2)]%; \
        /if (_sprawdz_nieodmienne({1})) \
            /let _return=$[strcat(_return, {1}, ' ')] %; \
            /shift %; \
        /else \
            /if     (_1_litera("y"))    /let _ret=$[strcat(substr({1}, 0, -1), 'ego')]%; \
            /elseif (_1_litera("i"))    /let _ret=$[strcat({1}, 'ego')]%; \
            /elseif (_1_litera("a"))    /let _ret=%{1}%; \
            /else                       /let _ret=$[strcat({1}, 'a')]%; \
            /endif %; \
            /let _return=$[strcat(_return, _ret, ' ')]%; \
            /shift %; \
        /endif %; \
    /done %; \
    /echo $[tolower(_return)]

/def odmien_m_nar = \
    /while ({#}) \
        /let _lit1=$[substr({1}, -1, 1)]%; \
        /let _lit2=$[substr({1}, -2, 2)]%; \
        /if (_sprawdz_nieodmienne({1})) \
            /let _return=$[strcat(_return, {1}, ' ')] %; \
            /shift %; \
        /else \
            /if     (_1_litera("y") | _1_litera("e")) \
                /let _ret=$[strcat(substr({1}, 0, -1), 'ym')]%; \
            /elseif (_1_litera("i"))    /let _ret=$[strcat({1}, 'm')]%; \
            /elseif (_1_litera("a"))    /let _ret=%{1}%; \
            /else                       /let _ret=$[strcat({1}, 'em')]%; \
            /endif %; \
            /let _return=$[strcat(_return, _ret, ' ')] %; \
            /shift %; \
        /endif %; \
    /done %; \
    /echo $[tolower(_return)]

/def odmien_m_mie = \
    /while ({#}) \
        /let _lit1=$[substr({1}, -1, 1)]%; \
        /let _lit2=$[substr({1}, -2, 2)]%; \
        /if (_sprawdz_nieodmienne({1})) \
            /let _return=$[strcat(_return, {1}, ' ')] %; \
            /shift %; \
        /else \
            /if (_2_litera("ra") | _2_litera("ga") | _2_litera("ha") | _2_litera("ja") | _2_litera("ka")) \
                /let _ret=$[strcat(substr({1}, 0, -1), 'iej')] %; \
            /elseif (_1_litera("a"))    /let _ret=$[strcat(substr({1}, 0, -1), 'ej')]%; \
            /elseif (_1_litera("i") | _1_litera("y")) \
                /let _ret=$[strcat({1}, 'm')]%; \
            /else                       /let _ret=$[strcat({1}, 'u')]%; \
            /endif %; \
            /let _return=$[strcat(_return, _ret, ' ')] %; \
            /shift %; \
        /endif %; \
    /done %; \
    /echo $[tolower(_return)]

; niezywotne (w sumie tylko biernik sie zmienia, ale zachowuje wszystkie kopiuje)
; ---------------------------------------------------------------------------------------
/def odmien_m_dop_n = \
    /while ({#}) \
        /let _lit1=$[substr({1}, -1, 1)]%; \
        /let _lit2=$[substr({1}, -2, 2)]%; \
        /if (_sprawdz_nieodmienne_n({1})) \
            /let _return=$[strcat(_return, {1}, ' ')] %; \
            /shift %; \
        /else \
            /if     (_2_litera("ka") | _2_litera("ga"))   /let _ret=$[strcat(substr({1}, 0, -1), 'iej')]%; \
            /elseif (_1_litera("y"))    /let _ret=$[strcat(substr({1}, 0, -1), 'ego')]%; \
            /elseif (_1_litera("i"))    /let _ret=$[strcat({1}, 'ego')]%; \
            /elseif (_1_litera("a"))    /let _ret=$[strcat(substr({1}, 0, -1), 'ej')]%; \
            /else                       /let _ret=$[strcat({1}, 'a')]%; \
            /endif %; \
            /let _return=$[strcat(_return, _ret, ' ')]%; \
            /shift %; \
        /endif %; \
    /done %; \
    /echo $[tolower(_return)]

/def odmien_m_cel_n = \
    /while ({#}) \
        /let _lit1=$[substr({1}, -1, 1)]%; \
        /let _lit2=$[substr({1}, -2, 2)]%; \
        /if (_sprawdz_nieodmienne_n({1})) \
            /let _return=$[strcat(_return, {1}, ' ')] %; \
            /shift %; \
        /else \
            /if     (_1_litera("i"))    /let _ret=$[strcat({1}, 'emu')]%; \
            /elseif (_2_litera("ka") | _2_litera("ga"))   /let _ret=$[strcat(substr({1}, 0, -1), 'iej')]%; \
            /elseif (_1_litera("y"))    /let _ret=$[strcat(substr({1}, 0, -1), 'emu')]%; \
            /elseif (_1_litera("a"))    /let _ret=$[strcat(substr({1}, 0, -1), 'ej')]%; \
            /else                       /let _ret=$[strcat({1}, 'owi')]%; \
            /endif %; \
            /let _return=$[strcat(_return, _ret, ' ')] %; \
            /shift %; \
        /endif %; \
    /done %; \
    /echo $[tolower(_return)]

/def odmien_m_bie_n = \
    /while ({#}) \
        /let _lit1=$[substr({1}, -1, 1)]%; \
        /let _lit2=$[substr({1}, -2, 2)]%; \
        /if (_sprawdz_nieodmienne_n({1})) \
            /let _return=$[strcat(_return, {1}, ' ')] %; \
            /shift %; \
        /else \
            /let _ret=%{1}%;\
            /let _return=$[strcat(_return, _ret, ' ')]%; \
            /shift %; \
        /endif %; \
    /done %; \
    /echo $[tolower(_return)]

/def odmien_m_nar_n = \
    /while ({#}) \
        /let _lit1=$[substr({1}, -1, 1)]%; \
        /let _lit2=$[substr({1}, -2, 2)]%; \
        /if (_sprawdz_nieodmienne_n({1})) \
            /let _return=$[strcat(_return, {1}, ' ')] %; \
            /shift %; \
        /else \
            /if     (_1_litera("y") | _1_litera("e")) \
                /let _ret=$[strcat(substr({1}, 0, -1), 'ym')]%; \
            /elseif (_1_litera("i"))    /let _ret=$[strcat({1}, 'm')]%; \
            /elseif (_1_litera("a"))    /let _ret=%{1}%; \
            /else                       /let _ret=$[strcat({1}, 'em')]%; \
            /endif %; \
            /let _return=$[strcat(_return, _ret, ' ')] %; \
            /shift %; \
        /endif %; \
    /done %; \
    /echo $[tolower(_return)]

/def odmien_m_mie_n = \
    /while ({#}) \
        /let _lit1=$[substr({1}, -1, 1)]%; \
        /let _lit2=$[substr({1}, -2, 2)]%; \
        /if (_sprawdz_nieodmienne_n({1})) \
            /let _return=$[strcat(_return, {1}, ' ')] %; \
            /shift %; \
        /else \
            /if (_2_litera("ra") | _2_litera("ga") | _2_litera("ha") | _2_litera("ja") | _2_litera("ka")) \
                /let _ret=$[strcat(substr({1}, 0, -1), 'iej')] %; \
            /elseif (_1_litera("a"))    /let _ret=$[strcat(substr({1}, 0, -1), 'ej')]%; \
            /elseif (_1_litera("i") | _1_litera("y")) \
                /let _ret=$[strcat({1}, 'm')]%; \
            /else                       /let _ret=$[strcat({1}, 'u')]%; \
            /endif %; \
            /let _return=$[strcat(_return, _ret, ' ')] %; \
            /shift %; \
        /endif %; \
    /done %; \
    /echo $[tolower(_return)]


;;; Update: 16-10-2006, napisalem maly def, ktory zwraca mi same koncowki
;;;                     podanej odmiany, usuwajac powtarzajace sie, obrane
;;;                     w | :)
;;;
;;; Np:
;;; > /zwroc_koncowki mezczyzna
;;; a|y|ie|e
;;;
;;; > /zwroc_koncowki kobieta
;;; ta|ty|cie|te
;;;
;;; > /zwroc_koncowki ogr
;;; a|owi|em|ze

;;; Def dziala nastepujaco: Porownuje po kolei przypadki,
;;; mian z dop, dop z cel, cel z bie, bie z nar, nar z mie
;;; Szuka miejsca, w ktorym litery wyrazu sa takie same, np.
;;;
;;; mezczyzna
;;; mezczyzny
;;;
;;; Wyraz ten ma w obu przypadkach to samo miejsce do 'mezczyzn' i def
;;; zapamieta numer tego miejsca, nastepnie porownywane sa kolejne dwa
;;; przypadki:
;;;
;;; mezczyzny
;;; mezczyznie
;;;
;;; Skrypt sprawdzi czy od miejsca ktory zapamietal nie zmieni sie cialo
;;; wyrazu, czyli 'mezczyzn', nie zmieni sie, wiec zapamietuje koncowke nr 3
;;; itp.

/def zwroc_koncowki = \
    /if ({*} =~ NULL) \
        /mesg -w Musisz podac jakas odmiane!%; \
        /return %; \
    /endif %; \
    /let _v1=%{1} %; \
    /if ({2} =~ NULL)   /let _v2=$(/m_dop %{_v1}) %; /else  /let _v2=%{2} %; /endif %; \
    /if ({3} =~ NULL)   /let _v3=$(/m_cel %{_v1}) %; /else  /let _v3=%{3} %; /endif %; \
    /if ({4} =~ NULL)   /let _v4=$(/m_bie %{_v1}) %; /else  /let _v4=%{4} %; /endif %; \
    /if ({5} =~ NULL)   /let _v5=$(/m_nar %{_v1}) %; /else  /let _v5=%{5} %; /endif %; \
    /if ({6} =~ NULL)   /let _v6=$(/m_mie %{_v1}) %; /else  /let _v6=%{6} %; /endif %; \
    /if (pocz =~ NULL) \
        /let pocz=$(/zwroc_poczatek %{_v1} %{_v2} %{_v3} %{_v4} %{_v5} %{_v6}) %; \
    /endif %; \
    /let _koncowki=$[konc(_v1, pocz)] \
                   $[konc(_v2, pocz)] \
                   $[konc(_v3, pocz)] \
                   $[konc(_v4, pocz)] \
                   $[konc(_v5, pocz)] \
                   $[konc(_v6, pocz)] %; \
    /let _koncowki=$(/unique %_koncowki) %; \
    /if (pocz =~ _var1 | pocz =~ _var2) \
        /echo $[replace(" ", "|", _koncowki)] %; \
    /else \
        /echo $[substr(replace(" ", "|", _koncowki), 0, -1)] %; \
    /endif

/def zwroc_poczatek = \
    /if ({*} =~ NULL) \
        /mesg -w Musisz podac jakas odmiane!%; \
        /return %; \
    /endif %; \
    /let _v1=%{1} %; \
    /if ({2} =~ NULL)   /let _v2=$(/m_dop %{_v1}) %; /else  /let _v2=%{2} %; /endif %; \
    /if ({3} =~ NULL)   /let _v3=$(/m_cel %{_v1}) %; /else  /let _v3=%{3} %; /endif %; \
    /if ({4} =~ NULL)   /let _v4=$(/m_bie %{_v1}) %; /else  /let _v4=%{4} %; /endif %; \
    /if ({5} =~ NULL)   /let _v5=$(/m_nar %{_v1}) %; /else  /let _v5=%{5} %; /endif %; \
    /if ({6} =~ NULL)   /let _v6=$(/m_mie %{_v1}) %; /else  /let _v6=%{6} %; /endif %; \
    /let _comp=$(/compare_two_words_str %_v1 %_v2) %; \
    /let _comp=$(/compare_two_words_str %_comp %_v3) %; \
    /let _comp=$(/compare_two_words_str %_comp %_v4) %; \
    /let _comp=$(/compare_two_words_str %_comp %_v5) %; \
    /let _comp=$(/compare_two_words_str %_comp %_v6) %; \
    /result _comp

/def zwroc_regexp = \
    /let _var1=%{1}%; \
    /let _var2=$(/m_dop %{_var1}) %; \
    /let _var3=$(/m_cel %{_var1}) %; \
    /let _var4=$(/m_bie %{_var1}) %; \
    /let _var5=$(/m_nar %{_var1}) %; \
    /let _var6=$(/m_mie %{_var1}) %; \
    /let pocz=$(/zwroc_poczatek %{_var1} %{_var2} %{_var3} %{_var4} %{_var5} %{_var6}) %; \
    /let konc=$(/zwroc_koncowki %{_var1} %{_var2} %{_var3} %{_var4} %{_var5} %{_var6}) %; \
    /let calosc=%{pocz}(%{konc}) %; \
    /result calosc

;/def zwroc_regexp = \
;    /let _var1=%{1}%; \
;    /let _var2=$(/m_dop %{_var1}) %; \
;    /let _var3=$(/m_cel %{_var1}) %; \
;    /let _var4=$(/m_bie %{_var1}) %; \
;    /let _var5=$(/m_nar %{_var1}) %; \
;    /let _var6=$(/m_mie %{_var1}) %; \
;    /let calosc=%{_var6}|%{_var5}|%{_var4}|%{_var3}|%{_var2}|%{_var1} %; \
;    /result calosc


/def -i konc = \
    /result substr({1}, strlen({2}), strlen({1}))


;;; stary sposob, korzystal z tablic, wiec straasznie duzo zarl procka,
;;; zwrocenie 4 regexpow trwalo okolo 1 sekundy
;/def compare_two_words = \
;    /let _w1=%{1} %; \
;    /let _w2=%{2} %; \
;    /let _tmp=0 %; \
;    /add_array _w1t $[substr(_w1, 0, 1)] %; \
;    /add_array _w2t $[substr(_w2, 0, 1)] %; \
;    /for i 1 $[strlen(_w1) - 1] \
;        /add_index _w1t $$[substr(_w1, i, 1)] %; \
;    /for i 1 $[strlen(_w2) - 1] \
;        /add_index _w2t $$[substr(_w2, i, 1)] %; \
;    /let _tmp2=$(/maxstr %_w1 %_w2) %; \
;    /for i 1 %%{_tmp2} \
;        /let _ind1=$$(/check_index _w1t %%{i}) %%; \
;        /let _ind2=$$(/check_index _w2t %%{i}) %%; \
;        /if (_ind1 =~ _ind2) \
;            /test ++_tmp %%; \
;        /else \
;            /test i:=%%{_tmp2} %%; \
;        /endif %; \
;    /result _tmp

;; nowy, skuteczniejszy sposob, nie korzysta z tablic, tylko z jednej zmiennej
/def compare_two_words = \
    /let _w1=%{1} %; \
    /let _w2=%{2} %; \
    /let _tmp=0 %; \
    /set _w1t=$[substr(_w1, 0, 1)] %; \
    /set _w2t=$[substr(_w2, 0, 1)] %; \
    /for i 1 $[strlen(_w1) - 1] \
        /set _w1t=%%{_w1t} $$[substr(_w1, i, 1)] %; \
    /for i 1 $[strlen(_w2) - 1] \
        /set _w2t=%%{_w2t} $$[substr(_w2, i, 1)] %; \
    /let _tmp2=$(/maxstr %_w1 %_w2) %; \
    /for i 1 _tmp2 \
        /let _ind1=$$(/nth %%{i} %%_w1t) %%; \
        /let _ind2=$$(/nth %%{i} %%_w2t) %%; \
        /if (_ind1 =~ _ind2) \
            /test ++_tmp %%; \
        /else \
            /test i:=%%{_tmp2} %%; \
        /endif %; \
    /unset _w1t %; \
    /unset _w2t %; \
    /result _tmp

/def compare_two_words_str = \
    /result substr({1}, 0, compare_two_words({1}, {2}))

/def -i maxint = \
    /if ({1} > {2}) \
        /result %{1} %; \
    /else \
        /result %{2} %; \
    /endif

/def -i minint = \
    /if ({1} < {2}) \
        /result %{1} %; \
    /else \
        /result %{2} %; \
    /endif

/def -i maxstr = \
    /if (strlen({1}) > strlen({2})) \
        /eval /echo $[strlen({1})] %; \
    /else \
        /eval /echo $[strlen({2})] %; \
    /endif

/def -i minstr = \
    /if (strlen({1}) < strlen({2})) \
        /eval /echo $[strlen({1})] %; \
    /else \
        /eval /echo $[strlen({2})] %; \
    /endif

