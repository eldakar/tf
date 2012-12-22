;
; Plik  : druzyna.tf
; Autor : volus
; Data  : 12/03/2006, 00:25:14
; Opis  : Wsio zwiazane z druzyna.
;

/def -F -mregexp -t' zaprasza cie do swojej druzyny\.$'	_druzyna_zaproszenie = \
    /beep 1 %; \
    /let _who=$[replace("[", "", replace("]", "", replace("(", "", replace(")", "", {PL}))))]%; \
    /substitute -p @{nBCwhite}%{PL}@{nCcyan}%{P0}@{nBCgreen}        <==== Zaproszenie do druzyny! @{nCgreen}/f9%;\
    /f9 -q dolacz do $$(/m_dop $$[tolower("%_who")])%;\
    /sprawdz_odmiane $[tolower(_who)]

;Nie jestes w zadnej druzynie!
;Druzyne prowadzi xxx
;1), zas ty jestes jej jedynym czlonkiem.
;2) i oprocz ciebie jest w niej jeszcze xxx.
;3) i oprocz ciebie sa w niej jeszcze xxx, xxx i yyy.
;Przewodzisz druzynie, w ktorej oprocz ciebie jest jeszcze xxx i xxx.


;; sprawdz_def, pomocne do sprawdzenia do ktorego P przypisywany jest string
;; w patternie, jesli nie mozemy go wyhaczyc ;]
;; po = \ dajemy poporstu sprawdz_def
/def sprawdz_def = \
    /set in=0%;\
    /while (in <= 15) \
        /eval /mesg L%{in}    = "%%{L%{in}}"%%;\
        /test ++in%;\
    /done %; \
    /set in=0%;\
    /echo %; \
    /mesg PL    = "%{PL}"%;\
    /while (in <= 15) \
        /eval /mesg P%{in}    = "%%{P%{in}}"%%;\
        /test ++in%;\
    /done %; \
    /mesg PR    = "%{PR}"%;\
    /unset in


/set _druzyna_catch=0

/def druzyna = \
    /send druzyna%; \
    /set _druzyna_catch=1

/def druzyna_purge_all = \
    /unset druzyna_leader%;\
    /unset druzyna_leader_d%;\
    /unset druzyna_leader_b%;\
    /unset druzyna_leader_n%;\
    /unset druzyna_grupa%;\
    /unset druzyna_grupa_d%;\
    /unset druzyna_grupa_b%;\
    /unset druzyna_grupa_n%;\
    /unset sizeof_czlonkowie

/def testuj_druzyne = \
    /if ({1} =~ "1") \
        /itrigger Druzyne prowadzi Daggerro, zas ty jestes jej jedynym czlonkiem.%;\
    /elseif ({1} =~ "2") \
        /itrigger Druzyne prowadzi duza elfka i oprocz ciebie jest w niej jeszcze Sprox.%;\
    /elseif ({1} =~ "3") \
        /itrigger Druzyne prowadzi duzy rycerz chaosu i oprocz ciebie sa w niej jeszcze: gburowaty maly krasnolud i Moradin.%;\
    /elseif ({1} =~ "4") \
        /itrigger Przewodzisz druzynie, w ktorej oprocz ciebie jest jeszcze mala duza elfka, zoltooki ogr i Bagrum.%;\
    /elseif ({1} =~ "5") \
        /itrigger Druzyne prowadzi Risika i oprocz ciebie sa w niej jeszcze: duzy mezczyzna, Santino, maly duzy krasnolud, krzywonogi potepieniec, zarosniety skaven, Sjorving, ponury okrutny lansjer, zimnooki gwardzista, przezroczysty duch, maly szlam, duza zjawa, wysoki szczuply jednooki elf, trzyreki piecionogi oficer, Nell, Verni, Ovvi, Nyara, Grot, Momo, Corben, Xan, Vink, Homer, Vanhel, Oghar, Isirit, Bofur, Tedeus i Tarael.%;\
    /else \
        /itrigger Nie jestes w zadnej druzynie!%;\
    /endif


/def -Fp10 -aBCgreen -mregexp -t'(dolacza|dolaczasz|dolaczajac)'	_druzyna_ktos_dolacza =\
;    /echo -p @{BCgreen}Prawdopodobnie zmienil sie stan druzyny!%;\
    /f11 -q /druzyna

/def -Fp10 -aCgreen -mregexp -t'(porzuca.* druzyne|rozwiazuje(sz|)|zmusza.* do opuszczenia druzyny|[Pp]rzekazuje(sz|)( ci|) prowadzenie)' _druzyna_ktos_opuszcza =\
;    /echo -p @{Cgreen}Mozliwe ze zmienil sie stan druzyny!%;\
    /f11 -q /druzyna

/def -Fp10 -aCgreen -mregexp -t'.*przedstawia .*jako:'  _druzyna_ktos_sie_przedstawil = \
;    /echo -p @{Cgreen}Ktos sie przedstawil, mozliwe, ze zmienil sie stan druzyny.%;\
    /f11 -q /druzyna

/def -F -E(_druzyna_catch) -P1Cyellow;5Cmagenta -mregexp -t'^Druzyne prowadzi (.*)( i oprocz ciebie (sa|jest) w niej jeszcze(:|) ([^.]*)\.$|, zas ty jestes jej jedynym czlonkiem\.$)'  _druzyna_lap_druzyne1 = \
    /druzyna_purge_all %; \
    /set druzyna_leader=$[tolower({P1})]%; \
    /set druzyna_leader=$[replace("(", "", replace(")", "", replace("[", "", replace("]", "", druzyna_leader))))]%;\
    /set druzyna_grupa=$[tolower({P5})]%; \
;    /echo [$[ftime("%H:%M:%S:%.")]]%{druzyna_grupa}%;\
    /if (druzyna_grupa =~ NULL) \
        /set druzyna_grupa=GRUPA%;\
    /else \
        /set druzyna_grupa=$[replace(" ", "_", replace(", ", "|", replace(" i ", "|", druzyna_grupa)))]%;\
        /ustaw_grupe %; \
    /endif %; \
    /ustaw_leadera %; \
    /ustaw_kolory_grupy %; \
    /mesg Grupa liczy sobie %{sizeof_czlonkowie} ludzi!%;\
;    /mesg Leader: %{druzyna_leader}%;\
;    /mesg [$[ftime("%H:%M:%S:%.")]]Reszta: %{druzyna_grupa} %;\
    /unset _druzyna_catch
;    /sprawdz_def

/def -F -E(_druzyna_catch) -P1Cmagenta -mregexp -t'^Przewodzisz druzynie, w ktorej oprocz ciebie jest jeszcze (.*)\.$' _druzyna_lap_druzyne2 = \
    /druzyna_purge_all %; \
    /set druzyna_leader=LEADER%; \
    /set druzyna_grupa=$[tolower({P1})]%;\
    /set druzyna_grupa=$[replace(" ", "_", replace(", ", "|", replace(" i ", "|", druzyna_grupa)))]%;\
    /ustaw_grupe %; \
    /ustaw_kolory_grupy %; \
;    /mesg Leader: %{druzyna_leader}%;\
;    /mesg Reszta: %{druzyna_grupa} %;\
    /mesg Grupa liczy sobie %{sizeof_czlonkowie} ludzi!%;\
    /unset _druzyna_catch
;    /sprawdz_def

/def -F -E(_druzyna_catch) -mregexp -P0Cgreen -t'^Nie jestes w zadnej druzynie\.$'  _druzyna_lap_druzyne3 = \
    /druzyna_purge_all %; \
    /druzyna_purge_kolory %; \
    /unset _druzyna_catch

/def ustaw_leadera = \
    /sprawdz_odmiane %{druzyna_leader}%;\
    /set druzyna_leader_d=$(/m_dop %{druzyna_leader})%;\
    /set druzyna_leader_b=$(/m_bie %{druzyna_leader})%;\
    /set druzyna_leader_n=$(/m_nar %{druzyna_leader})%;\
;    /mesg -i Leader ustawiony%;\
;    /mesg -i %{druzyna_leader_d}%;\
;    /mesg -i %{druzyna_leader_b}%;\
;    /mesg -i %{druzyna_leader_n}

/def druzyna_odmien_grupe = \
    /let ilosc_czlonkow_grupy=$[replace("|", " ", {1})]%; \
    /odmien_czlonkow %{ilosc_czlonkow_grupy} %; \

/def odmien_czlonkow = \
    /while ({#}) \
        /let _czlonek_grupy=$[replace("_", " ", {1})]%; \
        /sprawdz_odmiane %{_czlonek_grupy}%; \
        /let _czlonek_grupy_d=$(/m_dop %{_czlonek_grupy})%;\
        /let _czlonek_grupy_b=$(/m_bie %{_czlonek_grupy})%;\
        /let _czlonek_grupy_n=$(/m_nar %{_czlonek_grupy})%;\
        /if (druzyna_grupa_d =~ NULL) \
            /set druzyna_grupa_d=%{_czlonek_grupy_d}%;\
        /else \
            /set druzyna_grupa_d=%{druzyna_grupa_d}|%{_czlonek_grupy_d}%;\
        /endif%;\
        /if (druzyna_grupa_b =~ NULL) \
            /set druzyna_grupa_b=%{_czlonek_grupy_b}%;\
        /else \
            /set druzyna_grupa_b=%{druzyna_grupa_b}|%{_czlonek_grupy_b}%;\
        /endif%;\
        /if (druzyna_grupa_n =~ NULL) \
            /set druzyna_grupa_n=%{_czlonek_grupy_n}%;\
        /else \
            /set druzyna_grupa_n=%{druzyna_grupa_n}|%{_czlonek_grupy_n}%;\
        /endif %;\
        /test ++sizeof_czlonkowie%;\
        /shift %;\
    /done

/def ustaw_grupe = \
    /druzyna_usun_niepotrzebne %; \
    /druzyna_odmien_grupe %{druzyna_grupa}%;\
;    /mesg -i Grupa w dopelniaczu:   %{druzyna_grupa_d}%;\
;    /mesg -i Grupa w bierniku:      %{druzyna_grupa_b}%;\
;    /mesg -i Grupa w narzedniku:    %{druzyna_grupa_n}

/def druzyna_usun_niepotrzebne

/def druzyna_purge_kolory = \
    /purge _druzyna_kolory_*

/def ustaw_kolory_grupy = \
    /druzyna_purge_kolory %; \
    /let _druzyna_tmp=$[replace("_", " ", druzyna_grupa)] %; \
    /def -F -P0Cgreen   -t'(%{_druzyna_tmp})'       _druzyna_kolory_grupy       %; \
    /def -F -P0Cgreen   -t'(%{druzyna_grupa_d})'    _druzyna_kolory_grupy_d     %; \
    /def -F -P0Cgreen   -t'(%{druzyna_grupa_b})'    _druzyna_kolory_grupy_b     %; \
    /def -F -P0Cgreen   -t'(%{druzyna_grupa_n})'    _druzyna_kolory_grupy_n     %; \
    \
    /def -F -P0BCgreen  -t'(%{druzyna_leader})'     _druzyna_kolory_leader      %; \
    /def -F -P0BCgreen  -t'(%{druzyna_leader_d})'   _druzyna_kolory_leader_d    %; \
    /def -F -P0BCgreen  -t'(%{druzyna_leader_b})'   _druzyna_kolory_leader_b    %; \
    /def -F -P0BCgreen  -t'(%{druzyna_leader_n})'   _druzyna_kolory_leader_n

