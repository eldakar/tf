;
; Plik  : sprzet.tf
; Autor : volus
; Data  : 29/06/2006, 18:55:32
; Opis  : skrypt na wladanie bronia
;

; No wiec jest to skrypt, ktory ustawia konkretna bron lub tarcze
; - Bronie maja niektore unikatowe komendy wyjmowania oraz miejsca ich
;   przechowywania (np. _powyjmij_ miecz z _pochwy_)
;   dzieki temu skryptowi jest to wszystko mozliwe do ustawienia
; - Zakladam, ze tarcza zawsze jest w plecaku, wiec w niej komenda wyjmowania
;   nie jest ustawialnia, zawsze jest 'wez',
; - W 'komendy na ustawianie broni' macie konkretne komendy ktore trzeba
;   wpisac aby poprawnie skonfigurowac swoja bron
;   komendy wkladania / wyjmowania rowniez musza byc ustawione, nawet
;   jesli sa one standardowe 'wloz', 'wez'
;
; - konfiguracja broni nie jest automatycznie zapisywana, dziala tylko
;   w okresie biezacej sesji, ale mozna stworzyc male makro, ktore bedzie
;   zapisywalo do pliku (pozniej /ladowalnym), jedna uwaga, ten plik
;;; musi byc zaladowany przed stworzony plikiem loadowalnym, bo inaczej
;   zobaczycie tylko taki fajny ekran zafloodowany bledami, zostaliscie
;   ostrzezeni...
;
;   Ten skrypt wspolpracuje z moim skryptem na odmiane, wiec jesli nie masz
;   odmiany, wtedy skrypt ten rowniez nie bedzie dzialal,
;   Odmiana ostatnia, z 22-06-2006 (patrz changelog), gdzie dodana zostala
;   odmiana niezywotna
;
;   Narazie to tyle. Zycze milego testowania.
;
; ----------------------------------------------------------------------------


;============== komendy na ustawianie broni / tarczy / whatever ===============

/def ustaw_bron_1 = \
    /set    _sprzet_bron_1=%{*}     %; \
    /pecho Bron pierwsza ustawiona: %{_sprzet_bron_1} %; \
    /zapisz_sprzet -q

/def ustaw_bron_2 = \
    /set    _sprzet_bron_2=%{*}     %; \
    /pecho Bron   druga  ustawiona: %{_sprzet_bron_2} %; \
    /zapisz_sprzet -q


/def ustaw_tarcze =\
    /set    _sprzet_tarcza=%{*}     %; \
    /pecho Tarcza ustawiona: %{_sprzet_tarcza}


/def ustaw_pojemnik_bron_1 = \
    /set    _sprzet_pojemnik_bron_1=%{*} %; \
    /pecho Pojemnik na pierwsza bron ustawiony: %{_sprzet_pojemnik_bron_1}

/def ustaw_pojemnik_bron_2 = \
    /set    _sprzet_pojemnik_bron_2=%{*} %; \
    /pecho Pojemnik  na  druga  bron ustawiony: %{_sprzet_pojemnik_bron_2}

/def ustaw_pojemnik_tarcza = \
    /set    _sprzet_pojemnik_tarcza=%{*} %; \
    /pecho Pojemnik na tarcze ustawiony: %{_sprzet_pojemnik_tarcza}


/def ustaw_komende_wyjmowania_bron_1 = \
    /set    _sprzet_komenda_wyjmowania_bron_1=%{*} %; \
    /pecho Komenda na wyjmowanie broni pierwszej ustawiona: %{_sprzet_komenda_wyjmowania_bron_1}

/def ustaw_komende_wyjmowania_bron_2 = \
    /set    _sprzet_komenda_wyjmowania_bron_2=%{*} %; \
    /pecho Komenda  na  wyjmowanie broni drugiej ustawiona: %{_sprzet_komenda_wyjmowania_bron_2}


/def ustaw_komende_wkladania_bron_1 = \
    /set    _sprzet_komenda_wkladania_bron_1=%{*} %; \
    /pecho Komenda na wkladanie broni pierwszej ustawiona: %{_sprzet_komenda_wkladania_bron_1}

/def ustaw_komende_wkladania_bron_2 = \
    /set    _sprzet_komenda_wkladania_bron_2=%{*} %; \
    /pecho Komenda  na  wkladanie broni drugiej ustawiona: %{_sprzet_komenda_wkladania_bron_2}


/def ustaw_miejscowke_pojemnik_bron_1 = \
    /set    _sprzet_miejscowka_pojemnik_bron_1=%{*} %; \
    /pecho Miejscowka pojemnika dla broni pierwszej ustawiona: %{_sprzet_miejscowka_pojemnik_bron_1}

/def ustaw_miejscowke_pojemnik_bron_2 = \
    /set    _sprzet_miejscowka_pojemnik_bron_2=%{*} %; \
    /pecho Miejscowka pojemnika dla broni drugiej ustawiona: %{_sprzet_miejscowka_pojemnik_bron_2}


/def ustaw_pojemnik = \
    /set    _sprzet_pojemnik=%{*}%; \
    /pecho Pojemnik ogolny ustawiony: %{_sprzet_pojemnik}%; \
    /purge _sprzet_pojemnik_toggle_*%; \
    /def -F -mregexp -t'^$(/capitalize %{_sprzet_pojemnik}) juz jest otwart.' _sprzet_pojemnik_juz_otwarty = \
	/set _sprzet_pojemnik_otwarty=1%; \
    /def -F -mregexp -t'^(Otwierasz|Zamykasz).*$(/m_bie_n %{_sprzet_pojemnik})'    _sprzet_pojemnik_toggle_otwarcie = \
        /if ({P1} =~ "Otwierasz") \
            /set _sprzet_pojemnik_otwarty=1%%; \
        /elseif ({P1} =~ "Zamykasz") \
            /set _sprzet_pojemnik_otwarty=0%%; \
        /endif %%; \
        /if (_sprzet_pojemnik_otwarty) \
            /let _var=otwarcie %%; \
        /else \
            /let _var=zamkniecie %%; \
        /endif %%; \
        /substitute -p %%{P0}%%{PR} @{nCgreen}(Wykrywam @{B}%%{_var})


/set _pojemniki=|plecak|torba|worek|sakwa|

/def czy_pojemnik_standardowy = \
    /if (strstr(_pojemniki, strcat("|", {L}, "|")) > -1) \
        /result 1 %; \
    /endif

;=============== query :) =====================================================

/def query_bron_1 = /echo %{_sprzet_bron_1}
/def query_bron_2 = /echo %{_sprzet_bron_2}

/def query_tarcza = /echo %{_sprzet_tarcza}

/def query_pojemnik_bron_1 = /echo %{_sprzet_pojemnik_bron_1}
/def query_pojemnik_bron_2 = /echo %{_sprzet_pojemnik_bron_2}
/def query_pojemnik_tarcza = /echo %{_sprzet_pojemnik_tarcza}

/def query_komenda_wyjmowania_bron_1 = /echo %{_sprzet_komenda_wyjmowania_bron_1}
/def query_komenda_wyjmowania_bron_2 = /echo %{_sprzet_komenda_wyjmowania_bron_2}

/def query_komenda_wkladania_bron_1 = /echo %{_sprzet_komenda_wkladania_bron_1}
/def query_komenda_wkladania_bron_2 = /echo %{_sprzet_komenda_wkladania_bron_2}

/def query_miejscowka_pojemnika_bron_1 = /echo %{_sprzet_miejscowka_pojemnik_bron_1}
/def query_miejscowka_pojemnika_bron_2 = /echo %{_sprzet_miejscowka_pojemnik_bron_2}


/def query_pojemnik = /echo %{_sprzet_pojemnik}

;;;;; --- ogolne query
/def sprzet = \
    /pecho Bron 1: @{BCwhite}$(/query_bron_1)@{n} (@{BCgreen}$(/query_pojemnik_bron_1)@{n} [@{BCyellow}$(/query_komenda_wyjmowania_bron_1) / $(/query_komenda_wkladania_bron_1)@{n}]) (@{BCgreen}$(/query_miejscowka_pojemnika_bron_1)@{n})%; \
    /pecho Bron 2: @{BCwhite}$(/query_bron_2)@{n} (@{BCgreen}$(/query_pojemnik_bron_2)@{n} [@{BCyellow}$(/query_komenda_wyjmowania_bron_2) / $(/query_komenda_wkladania_bron_2)@{n}]) (@{BCgreen}$(/query_miejscowka_pojemnika_bron_2)@{n})%; \
    /pecho Tarcza: @{BCwhite}$(/query_tarcza)@{n} (@{BCgreen}$(/query_pojemnik_tarcza)@{n}) %; \
    /pecho Plecak: @{BCwhite}$(/query_pojemnik)@{n}
    
;========================= komendy do uzywania ================================



;;;            -------- dobywanie  broni ----------
/def db1 = \
    /if ($(/czy_pojemnik_standardowy $(/query_pojemnik_bron_1))) \
        /if (!_sprzet_pojemnik_otwarty) \
            otworz $(/m_bie_n $(/query_pojemnik_bron_1)) %; \
        /endif %; \
    /endif %; \
    /send $(/query_komenda_wyjmowania_bron_1) $(/m_bie_n $(/query_bron_1)) z $(/m_dop_n $(/query_pojemnik_bron_1)) %; \
    /send dobadz $(/m_dop_n $(/query_bron_1))

;; alias
/def db = /db1

/def db2 = \
    /if ($(/czy_pojemnik_standardowy $(/query_pojemnik_bron_2))) \
        /if (!_sprzet_pojemnik_otwarty) \
            otworz $(/m_bie_n $(/query_pojemnik_bron_2)) %; \
        /endif %; \
    /endif %; \
    /send $(/query_komenda_wyjmowania_bron_2) $(/m_bie_n $(/query_bron_2)) z $(/m_dop_n $(/query_pojemnik_bron_2)) %; \
    /send dobadz $(/m_dop_n $(/query_bron_2))


;;;            --------- opuszczanie broni ----------
/def op1 = \
    /if ($(/czy_pojemnik_standardowy $(/query_pojemnik_bron_1))) \
        /if (!_sprzet_pojemnik_otwarty) \
            otworz $(/m_bie_n $(/query_pojemnik_bron_1)) %; \
        /endif %; \
    /endif %; \
    /send opusc $(/m_bie_n $(/query_bron_1)) %; \
    /send $(/query_komenda_wkladania_bron_1) $(/m_bie_n $(/query_bron_1)) do $(/m_dop_n $(/query_pojemnik_bron_1))

/def op2 = \
    /if ($(/czy_pojemnik_standardowy $(/query_pojemnik_bron_2))) \
        /if (!_sprzet_pojemnik_otwarty) \
            otworz $(/m_bie_n $(/query_pojemnik_bron_2)) %; \
        /endif %; \
    /endif %; \
    /send opusc $(/m_bie_n $(/query_bron_2)) %; \
    /send $(/query_komenda_wkladania_bron_2) $(/m_bie_n $(/query_bron_2)) do $(/m_dop_n $(/query_pojemnik_bron_2))

;; alias
/def op = /op1

;;;            -------- manewry z tarcza -------------
/def zt = \
    /if ($(/czy_pojemnik_standardowy $(/query_pojemnik_tarcza))) \
        /if (!_sprzet_pojemnik_otwarty) \
            otworz $(/m_bie_n $(/query_pojemnik_tarcza)) %; \
        /endif %; \
    /endif %; \
    /send wez   $(/m_bie_n $(/query_tarcza)) z $(/m_dop_n $(/query_pojemnik_tarcza)) %; \
    /send zaloz $(/m_bie_n $(/query_tarcza))

/def ot = \
    /if ($(/czy_pojemnik_standardowy $(/query_pojemnik_tarcza))) \
        /if (!_sprzet_pojemnik_otwarty) \
            otworz $(/m_bie_n $(/query_pojemnik_tarcza)) %; \
        /endif %; \
    /endif %; \
    /send zdejmij $(/m_bie_n $(/query_tarcza)) %; \
    /send wloz    $(/m_bie_n $(/query_tarcza)) do $(/m_dop_n $(/query_pojemnik_tarcza))

;;;            -------- przypinanie pochew -------------
/def przypnij_1 = \
    /send poprzypnij $(/m_bie_n $(/query_pojemnik_bron_1)) $(/query_miejscowka_pojemnika_bron_1)
    
/def przypnij_2 = \
    /send poprzypnij $(/m_bie_n $(/query_pojemnik_bron_2)) $(/query_miejscowka_pojemnika_bron_2)

;;;            --------- zakladanie plecaka ------------
/def zaloz_pojemnik = \
    /send zaloz $(/m_bie_n $(/query_pojemnik))
    
;;;            ------------ dual lub tarcza + bron ----------
/def dbd = \
    /db1 %; /db2
    
/def opd = \
    /op2 %; /op2
    
/def dbt = \
    /db1 %; /zt 
    
/def opt = \
    /op1 %; /ot

;;; inne aliasy
/def ub1 = /ustaw_bron_1 %{*}
/def ub2 = /ustaw_bron_2 %{*}
/def ut  = /ustaw_tarcze %{*}

/def ukwy1 = /ustaw_komende_wyjmowania_bron_1 %{*}
/def ukwy2 = /ustaw_komende_wyjmowania_bron_2 %{*}

/def ukwk1 = /ustaw_komende_wkladania_bron_1 %{*}
/def ukwk2 = /ustaw_komende_wkladania_bron_2 %{*}

/def upb1  = /ustaw_pojemnik_bron_1 %{*}
/def upb2  = /ustaw_pojemnik_bron_2 %{*}

/def up    = /ustaw_pojemnik %{*}
/def upt   = /ustaw_pojemnik_tarcza %{*}

;;; player-specific stuff
/def query_sprzet_db_file = \
    /echo %{TFDIR}/mortal/%{_obecny_gracz}/sprzet_%{_obecny_gracz}.db

/def zaladuj_sprzet = \
    /load -q $(/query_sprzet_db_file)

/def zapisz_sprzet = \
    /if (!getopts("q", "")) \
        /return 0%; \
    /endif %; \
    /let _player_sprzet_db $(/query_sprzet_db_file) %; \
    /echo ;; Plik z danymi sprzetu, utworzony automatycznie, nie zmieniac! %| /writefile %{_player_sprzet_db} %; \
    /test fwrite(_player_sprzet_db, "/ustaw_bron_1 $(/query_bron_1)") %; \
    /test fwrite(_player_sprzet_db, "/ustaw_bron_2 $(/query_bron_2)") %; \
    /test fwrite(_player_sprzet_db, "/ustaw_pojemnik_bron_1 $(/query_pojemnik_bron_1)") %; \
    /test fwrite(_player_sprzet_db, "/ustaw_pojemnik_bron_2 $(/query_pojemnik_bron_2)") %; \
    /test fwrite(_player_sprzet_db, "/ustaw_komende_wkladania_bron_1 $(/query_komenda_wkladania_bron_1)") %; \
    /test fwrite(_player_sprzet_db, "/ustaw_komende_wkladania_bron_2 $(/query_komenda_wkladania_bron_2)") %; \
    /test fwrite(_player_sprzet_db, "/ustaw_komende_wyjmowania_bron_1 $(/query_komenda_wyjmowania_bron_1)") %; \
    /test fwrite(_player_sprzet_db, "/ustaw_komende_wyjmowania_bron_2 $(/query_komenda_wyjmowania_bron_2)") %; \
    /test fwrite(_player_sprzet_db, "/ustaw_miejscowke_pojemnik_bron_1 $(/query_miejscowka_pojemnika_bron_1)") %; \
    /test fwrite(_player_sprzet_db, "/ustaw_miejscowke_pojemnik_bron_2 $(/query_miejscowka_pojemnika_bron_2)") %; \
    /test fwrite(_player_sprzet_db, "/ustaw_pojemnik $(/query_pojemnik)") %; \
    /test fwrite(_player_sprzet_db, "/ustaw_tarcze $(/query_tarcza)") %; \
    /test fwrite(_player_sprzet_db, "/ustaw_pojemnik_tarcza $(/query_pojemnik_tarcza)") %; \
    /if (!opt_q) /mesg Dane zostaly zapisane do pliku %{_player_sprzet_db} %; /endif

;; Tworzymy hook, ktory przy 'zakanczaniu' lub blizej niesprecyzowanej sytuacji disconnectu zapisze aktualny sprzet
/def -F -wArka -h'DISCONNECT'  _arka_disc_zapisz_sprzet = \
    /mesg -i Zostales rozlaczony z MUD'em, zapisuje aktualny sprzet. %; \
    /zapisz_sprzet

;; ladownaie sprzetu wewnatrz pliku start_arka.tf
