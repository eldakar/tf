;
; Plik  : nightal_sprzet.tf
; Autor : volus
; Data  : 29/06/2006, 19:34:00
; Opis  :
;

;; inherit "sprzet.tf"; <- najwazniejszy plik, MUSI byc zaladowany PRZED tym plikiem
;; :PPPP

;; Zapisywac sprzet bedziemy na 2 sposoby:
;  1) hook disconnecta, wtedy automagicznie bedzie sprzet zapisywany
;  2) komenda /zapisz_sprzet_n (n - bo nightal ;P)

/if ($(/list ustaw_bron_1) =~ NULL) \
    /mesg -w Nie masz zaladowanego podstawowego sprzetu obslugujacego bronie! 'sprzet.tf' %; \
    /mesg -w Podczas ladownia sprzetu wyswietli sie duza ilosc bledow oraz skrypt nie bedzie %; \
    /mesg -w Dzialal tak jak powinien! Przed zaladowaniem tego pliku powinienes miec %; \
    /mesg -w Zaladowany plik 'sprzet.tf' ! %; \
/endif


;;;; tymczasowo, bo zrobilem fwrite("str", "gdzie") nizej i mi sie nie chcialo
;;;; poprawiac, wiec zrobilem taki maly defik :P
/def -i rfwrite = \
    /test fwrite({2}, {1})


/eval /set _nightalowy_sprzet_db=%{TFDIR}/nightal/nightal_sprzet.db


/def zaladuj_sprzet_n = \
    /load -q %{_nightalowy_sprzet_db}

/def zapisz_sprzet_n = \
    /if (!getopts("q", "")) \
        /return 0%; \
    /endif %; \
    /echo ;; Plik z danymi sprzetu, utworzony automatycznie, nie zmieniac! %| /writefile %{_nightalowy_sprzet_db} %; \
    /test rfwrite("/ustaw_bron_1 $(/query_bron_1)", _nightalowy_sprzet_db) %; \
    /test rfwrite("/ustaw_bron_2 $(/query_bron_2)", _nightalowy_sprzet_db) %; \
    /test rfwrite("", _nightalowy_sprzet_db) %; \
    /test rfwrite("/ustaw_pojemnik_bron_1 $(/query_pojemnik_bron_1)", _nightalowy_sprzet_db) %; \
    /test rfwrite("/ustaw_pojemnik_bron_2 $(/query_pojemnik_bron_2)", _nightalowy_sprzet_db) %; \
    /test rfwrite("", _nightalowy_sprzet_db) %; \
    /test rfwrite("/ustaw_komende_wkladania_bron_1 $(/query_komenda_wkladania_bron_1)", _nightalowy_sprzet_db) %; \
    /test rfwrite("/ustaw_komende_wkladania_bron_2 $(/query_komenda_wkladania_bron_2)", _nightalowy_sprzet_db) %; \
    /test rfwrite("", _nightalowy_sprzet_db) %; \
    /test rfwrite("/ustaw_komende_wyjmowania_bron_1 $(/query_komenda_wyjmowania_bron_1)", _nightalowy_sprzet_db) %; \
    /test rfwrite("/ustaw_komende_wyjmowania_bron_2 $(/query_komenda_wyjmowania_bron_2)", _nightalowy_sprzet_db) %; \
    /test rfwrite("", _nightalowy_sprzet_db) %; \
    /test rfwrite("/ustaw_pojemnik $(/query_pojemnik)", _nightalowy_sprzet_db) %; \
    /test rfwrite("", _nightalowy_sprzet_db) %; \
    /test rfwrite("/ustaw_tarcze $(/query_tarcza)", _nightalowy_sprzet_db) %; \
    /test rfwrite("/ustaw_pojemnik_tarcza $(/query_pojemnik_tarcza)", _nightalowy_sprzet_db) %; \
    /test rfwrite(";; Koniec automatycznie generowanych danych", _nightalowy_sprzet_db) %; \
    /if (!opt_q) /mesg Dane zostaly zapisane do pliku %{_nightalowy_sprzet_db} %; /endif

;; Tworzymy hook, ktory przy 'zakanczaniu' lub blizej niesprecyzowanej sytuacji disconnectu zapisze aktualny sprzet
/def -F -wNight -h'DISCONNECT'  _disc_zapisz_sprzet = \
    /mesg -i Zostales rozlaczony z MUD'em, zapisuje aktualny sprzet. %; \
    /zapisz_sprzet_n


;; No i ladujemy sprzecik aktualny;
/zaladuj_sprzet_n

