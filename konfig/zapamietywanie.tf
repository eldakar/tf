;
; Plik  : zapamietywanie.tf
; Autor : volus
; Data  : 25/01/2007, 19:22:29
; Opis  : Skrypt zapamietujacy imiona ludzi, ktorzy sie nam przedstawili
;         Przedstawia osoby w postaci:
;
;         Dlugowlosy zamyslony czarnoksieznik (Rindarin).
;
;         Kolor opisu jest zalezny od odpowiedniego ustawienia przez gracza;
;         Kazdy opis ma swoj numer identyfikacyjny i glownie na nim bedzie
;         sie operowac. Zapamietywanie nastepuje automatycznie, zawsze
;         pokazuje sie kto jest zapamietywany oraz wyswietla sie numer
;         identyfikacyjny tejze osoby, aby pozniej ustawic odpowiednie opcje
;         A te opcje to:
;
;         -- /zzap numer_id opcje
;
;         gdzie numer_id to numer identyfikacyjny osoby ktora chcemy zmienic
;         a 'opcje' to:
;         * wrog - osoba bedzie kolorowana na czerwono oraz ustawiona jako wrog
;         * npc  - osoba bedzie albo npcem albo neutralna, czyli nie bedzie kolorowana
;         * przyjaciel - osoba bedzie kolorowana na zolto, zaznaczona jako przyjaciel
;         * wiz - osoba jest czarodziejem :)
;
;         -- /zgilr numer_id short
;         -- /zgilz numer_id short
;
;         zgilr ustawia wedle numer_id w jakiej gildii rasowej znajduje sie dana
;         osoba, oczywiscie 'gildia rasowa' tutaj podchodzi pod stowarzyszenie,
;         ktore nie daje zawodu :)
;
;         zgilz ustawia wedle numer_id w jakiej gildii zawodowej znajduje sie dana
;         osoba, oczywiscie 'gildia zawodowa' tutaj podchodzi pod stowarzyszenie,
;         ktore daje zawod;
;
;         nie bedzie ustawiania jaki zawod ma dana osoba, bo tu chodzi tylko
;         o to aby wiedziec w jakim stowarzyszeniu sie owa osoba znajduje
;
;         Inne komendy:
;         /ktoto opis lub imie / licz
;
;         zwroci liste osob wraz z ich id oraz opcjami, ktore pasuja do patterna
;         opis lub imie, a jesli za argument podamy 'licz' wtedy policzy nam ile
;         osob zapamietanych znajduje sie w bazie danych
;
;         Defaultowo jak sie jakas osoba przedstawi, ustawiana jest jako
;         neutralna (npc) oraz nie pochodzaca z zadnej gildii.
;
;         Komenda /info id, gdzie id to numer identyfikacyjny osoby, zwroci nam
;         wszelkie informacje na temat osoby, ktora sie kryje pod tym numerem
;
;
;
;
;
;
;       Zrobione:
;
;    *  przy przedstawianiu zapisuje do bazy danych ludzi
;    *  przy odpalaniu skrypty robi odpowiednie definicje
;    *  sprawdza powtarzajace sie imiona, nie doprowadza do
;       dublujacych sie imion
;
;
;       Do zrobienia:
;
;    *  komendy oznaczajace typ oraz gildie osob
;    *  komenda listujaca wedle opisu lub imiona
;    *  komenda pokazujaca calkowite informacje na temat zadania podanego
;       imienia lub id
;

/eval /set    _zap_database=%{DBDIR}/zapamietywanie.db

/set    _kolor_npc=n
/set    _kolor_wrog=BCred
/set    _kolor_przyjaciel=Cyellow
/set    _kolor_wiz=Cmagenta

/set    _zap_npc=0
/set    _zap_wrog=1
/set    _zap_przyjaciel=2
/set    _zap_wiz=3

/set    _zap_last_id=1

/def test_zap = \
    /itrigger Dlugowlosy ponury mezczyzna przedstawia sie jako:%; \
    /itrigger Jasio, szkolny rozrabiaka, mezczyzna.

/def test_zap2 = \
    /itrigger Krotkowlosy ponury elf przedstawia sie jako:%; \
    /itrigger Kazio, elf.

/def test_zap3 = \
    /itrigger Gruby ciezki krasnolud przedstawia sie jako:%; \
    /itrigger Bofur z Twierdzy Karak Varn, Niepokonany Mistrz Areny Rodu von Raugen zwany Rosomakiem, krasnolud.

/def test_zap4 = \
    /itrigger Zlotowlosy niebieskooki elf przedstawia sie jako:%; \
    /itrigger Atel, elf.

/def test_zap5 = \
    /itrigger Powazny ponury mezczyzna przedstawia sie jako:%; \
    /itrigger Daggerro z Novigradu, mezczyzna.

/def test_zap6 = \
    /itrigger Stary stetryczaly krasnolud czarodziej przedstawia sie jako:%; \
    /itrigger Szlachetny Vaxon Gernstein z Karak Varn, Doradca Najwyzszego Krola Karaz Ankor, krasnolud.

;; na samym poczatku musimy znalezc najwiekszy identyfikator
/def _zap_znajdz_last_id = \
    /quote -S /test _zap_znajdz_ostatni_id('"%{_zap_database}")

/def _zap_znajdz_ostatni_id = \
    /let _id=%{1} %; \
    /if (_id > _zap_last_id) \
        /set _zap_last_id=%{_id} %; \
    /endif

/_zap_znajdz_last_id

/eval /pecho Ostatni id znaleziony: %{_zap_last_id}

;; ustawiamy, czy imiona maja byc pokazywane
/def imiona_toggle = \
    /if (_zap_pokazuj_imie) \
        /set _zap_pokazuj_imie=0%; \
        /pecho Od teraz NIE pokazujemy imion. %; \
    /else \
        /set _zap_pokazuj_imie=1%; \
        /pecho Od teraz pokazujemy imiona.%; \
    /endif

;; na poczatku zawsze wlaczone
/set _zap_pokazuj_imie=1

;; funkcja usuwajaca wpis po identyfikatorze
/def _zap_usun_wpis = \
    /sys cat %{_zap_database} | grep -v \\"%{1}\\", >> %{_zap_database}.bq %; \
    /sys mv %{_zap_database}.bq %{_zap_database} %; \

;; funkcje szukajace identyfikator po imieniu
/def _zap_znajdz_id_po_imieniu = \
    /set _zap_szukane_id=0%;\
    /set _zap_szukane_imie=$[tolower({*})] %; \
    /quote -S /test _zap_sprawdz_id_po_imieniu('"%{_zap_database}")%;\
    /repeat -0.1 1 /unset _zap_szukane_id%; \
    /unset _zap_szukane_imie %; \
    /result %{_zap_szukane_id} %; \

/def _zap_sprawdz_id_po_imieniu = \
    /let _imie=$[tolower({3})] %; \
    /if (_zap_szukane_imie =~ _imie) \
        /set _zap_szukane_id %{1} %;\
    /endif

;; funkcje szukajace opis po imieniu
/def _zap_znajdz_opis_po_imieniu = \
    /set _zap_szukane_imie=$[tolower({*})]%; \
    /set _zap_znaleziony_opis=Brak opisu%;\
    /quote -S /test _zap_sprawdz_opis_po_imieniu('"%{_zap_database}")%;\
    /repeat -0.1 1 /unset _zap_znaleziony_opis%;\
    /unset _zap_szukane_imie%;\
    /result "%{_zap_znaleziony_opis}"

/def _zap_sprawdz_opis_po_imieniu = \
    /let _imie=$[tolower({3})] %; \
    /if (_zap_szukane_imie =~ _imie) \
        /set _zap_znaleziony_opis %{2}%; \
    /endif

;; funkcje szukajace opis po id
/def _zap_znajdz_opis_po_id = \
    /set _zap_szukane_id=%{1}%; \
    /set _zap_znaleziony_opis=Brak opisu%;\
    /quote -S /test _zap_sprawdz_opis_po_id('"%{_zap_database}")%;\
    /repeat -0.1 1 /unset _zap_znaleziony_opis%;\
    /unset _zap_szukane_id%;\
    /result "%{_zap_znaleziony_opis}"

/def _zap_sprawdz_opis_po_id = \
    /let _id=%{1} %; \
    /if (_zap_szukane_id =~ _id) \
        /set _zap_znaleziony_opis %{2}%; \
    /endif

;; funkcje szukajace tytulu po id
/def _zap_znajdz_tytul_po_id = \
    /set _zap_szukane_id=%{*}%; \
    /set _zap_znaleziony_tytul=%;\
    /quote -S /test _zap_sprawdz_tytul_po_id('"%{_zap_database}")%;\
    /repeat -0.1 1 /unset _zap_znaleziony_tytul%;\
    /unset _zap_szukane_id%;\
    /result "%{_zap_znaleziony_tytul}"

/def _zap_sprawdz_tytul_po_id = \
    /let _id=%{1} %; \
    /if (_zap_szukane_id =~ _id) \
        /set _zap_znaleziony_tytul %{4}%; \
    /endif

;; funkcje szukajace ustawionego typu po id
/def _zap_znajdz_typ_po_id = \
    /set _zap_szukane_id=%{*}%; \
    /set _zap_znaleziony_typ=%;\
    /quote -S /test _zap_sprawdz_typ_po_id('"%{_zap_database}")%;\
    /repeat -0.1 1 /unset _zap_znaleziony_typ%;\
    /unset _zap_szukane_id%;\
    /result "%{_zap_znaleziony_typ}"

/def _zap_sprawdz_typ_po_id = \
    /let _id=%{1} %; \
    /if (_zap_szukane_id =~ _id) \
        /set _zap_znaleziony_typ %{5}%; \
    /endif

;; funkcje szukajace ustawionej gildi rasowej po id
/def _zap_znajdz_gilr_po_id = \
    /set _zap_szukane_id=%{*}%; \
    /set _zap_znaleziona_gr=%;\
    /quote -S /test _zap_sprawdz_gr_po_id('"%{_zap_database}")%;\
    /repeat -0.1 1 /unset _zap_znaleziona_gr%;\
    /unset _zap_szukane_id%;\
    /result "%{_zap_znaleziona_gr}"

/def _zap_sprawdz_gr_po_id = \
    /let _id=%{1} %; \
    /if (_zap_szukane_id =~ _id) \
        /set _zap_znaleziona_gr %{6}%; \
    /endif

;; funkcje szukajace ustawionej gildii zawodowej po id
/def _zap_znajdz_gilz_po_id = \
    /set _zap_szukane_id=%{*}%; \
    /set _zap_znaleziona_gz=%;\
    /quote -S /test _zap_sprawdz_gz_po_id('"%{_zap_database}")%;\
    /repeat -0.1 1 /unset _zap_znaleziona_gz%;\
    /unset _zap_szukane_id%;\
    /result "%{_zap_znaleziona_gz}"

/def _zap_sprawdz_gz_po_id = \
    /let _id=%{1} %; \
    /if (_zap_szukane_id =~ _id) \
        /set _zap_znaleziona_gz %{7}%; \
    /endif

;; funkcje wczytujace dane z bazy danych oraz tworzace odpowiednie definicje
/def _zap_wczytaj_osoby = \
    /purge _zap_definicja_osoba_* %; \
    /quote -S /test _zap_wczytaj_osobe('"%{_zap_database}")

/def _zap_wczytaj_osobe = \
    /let _id=%{1}    %; \
    /let _short=%{2} %; \
    /let _imie=%{3}  %; \
    /let _tyt=%{4}   %; \
    /let _typ=%{5}   %; \
    /let _gilr=%{6}  %; \
    /let _gilz=%{7}  %; \
    /let _data=%{8}  %; \
    /if (_typ == 0) \
        /let _col=%{_kolor_npc} %; \
    /elseif (_typ == 1) \
        /let _col=%{_kolor_wrog} %; \
    /elseif (_typ == 2) \
        /let _col=%{_kolor_przyjaciel} %; \
    /elseif (_typ == 3) \
        /let _col=%{_kolor_wiz} %; \
    /endif %; \
    /if (strlen(_gilr) == 0) \
        /if (strlen(_gilz) == 0) \
            /def -Fp10 -E(_zap_pokazuj_imie) -mregexp -t'(%{_short})([,. ])' _zap_definicja_osoba_%{_id} = \
                /substitute -p %%{PL}@{%{_col}}%%{P1}@{nBCwhite} (%{_imie})@{n}%%{P2}%%{PR}%;\
        /else \
            /def -Fp10 -E(_zap_pokazuj_imie) -mregexp -t'(%{_short})([,. ])' _zap_definicja_osoba_%{_id} = \
                /substitute -p %%{PL}@{%{_col}}%%{P1}@{nBCwhite} (%{_imie} @{nCgreen}%{_gilz}@{nBCwhite})@{n}%%{P2}%%{PR}%;\
        /endif %; \
    /else \
        /if (strlen(_gilz) == 0) \
            /def -Fp10 -E(_zap_pokazuj_imie) -mregexp -t'(%{_short})([,. ])' _zap_definicja_osoba_%{_id} = \
                /substitute -p %%{PL}@{%{_col}}%%{P1}@{nBCwhite} (%{_imie} @{nCcyan}%{_gilr}@{nBCwhite})@{n}%%{P2}%%{PR}%;\
        /else \
            /def -Fp10 -E(_zap_pokazuj_imie) -mregexp -t'(%{_short})([,. ])' _zap_definicja_osoba_%{_id} = \
                /substitute -p %%{PL}@{%{_col}}%%{P1}@{nBCwhite} (%{_imie} @{nCcyan}%{_gilr} @{nCgreen}%{_gilz}@{nBCwhite})@{n}%%{P2}%%{PR}%;\
        /endif %; \
    /endif

/pecho Zaczynam wczytywac imiona oraz tworzyc definicje...
/_zap_wczytaj_osoby
/pecho Skonczylem wczytywac oraz tworzyc definicje.


/def -Fp200 -mregexp -t'^(.*) przedstawia sie jako:$' _zap_catch1 = \
    /def -n1 -Fp200 -mregexp -t'^(Rekrut |Rekrutka |Praktykant |Praktykantka |Szlachetny |Szlachetna |Czcigodny |Czcigodna |Senior |Seniorita |Lord |Lady |Mistrz |Mistrzyni |)([^, ]*)([, ](.*)|), ([^.]*)\.$$' _zap_catch2 = \
        /let _short=%{P1} %%; \
        /let _imie=%%{P2} %%; \
        /let _rasa=%%{P5} %%; \
        /let _tyt=%%{P4} %%; \
        /test ++_zap_last_id %%; \
        /let _id=%%{_zap_last_id} %%; \
        /test _zap_zapisz_osobe(_id, tolower(_short), _imie, _tyt, 0, "", "", "$[ftime("%F")]")

/def _zap_zapisz_osobe = \
    /let _id=%{1}    %; \
    /let _short=%{2} %; \
    /let _imie=%{3}  %; \
    /let _tyt=%{4}   %; \
    /let _typ=%{5}   %; \
    /let _gilr=%{6}  %; \
    /let _gilz=%{7}  %; \
    /let _data=%{8}  %; \
    /test _tmp := _zap_znajdz_id_po_imieniu(_imie) %; \
    /if (_tmp == 0) \
;       imion nie zapisujemy jako osobny wpis
        /if (tolower(_short) !~ tolower(_imie)) \
            /pecho Zapamietuje: %{_imie} %; \
            /echo "%{_id}","%{_short}","%{_imie}","%{_tyt}","%{_typ}","%{_gilr}","%{_gilz}","%{_data}" %| /writefile -a %{_zap_database}%; \
            /_zap_wczytaj_osoby %; \
        /endif %; \
    /else \
;       imion nie zapisujemy jako osobny wpis
        /if (tolower(_short) !~ tolower(_imie)) \
            /_zap_usun_wpis %{_tmp} %; \
            /test _tmp4 := _zap_znajdz_typ_po_id(_tmp) %; \
            /test _tmp5 := _zap_znajdz_gilr_po_id(_tmp) %; \
            /test _tmp6 := _zap_znajdz_gilz_po_id(_tmp) %; \
;            /pecho Updatuje zaznaczenia %; \
            /echo "%{_id}","%{_short}","%{_imie}","%{_tyt}","%{_tmp4}","%{_tmp5}","%{_tmp6}","%{_data}" %| /writefile -a %{_zap_database}%; \
            /_zap_wczytaj_osoby %; \
        /endif %; \
    /endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; konwerter starej bazy danych na nowa ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;; konwertuje imie, tytul i short       ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 1 - imie
;;; 2 - short
;;; 3 - tytul
;
;/set _stara_baza_danych=/home/jacek/TF/skrypty/2005-10-19/arkadia/imiona.db
;/def konwertuj_imiona = \
;    /pecho Zaczynam konwersje imion... %; \
;    /quote -S /test _konwertuj_imie('"%{_stara_baza_danych}") %; \
;    /pecho Skonczylem konwertowac imiona!
;    
;/def _konwertuj_imie = \
;        /let _short=$[tolower({2})] %; \
;        /let _imie=%{1} %; \
;        /let _tyt=$[substr({3}, 1, strrchr({3}, ","))] %; \
;        /if (strlen(_tyt) > 0) \
;            /let _tyt=$[substr(_tyt, 0, strlen(_tyt) - 1)] %; \
;        /endif %; \
;        /test ++_zap_last_id %; \
;        /let _id=%{_zap_last_id} %; \
;        /test _zap_zapisz_osobe(_id, _short, _imie, _tyt, 0, "", "", "$[ftime("%F")]")
 