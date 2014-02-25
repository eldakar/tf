;
; Plik  : login.tf
; Autor : volus
; Data  : 15/06/2006, 14:09:25
; Opis  : skrypt sprawdzanie paru rzeczy przy logowaniu sie do gry
;

;; tabelka w bazie
/if (_use_sql) \
    /test query("create table if not exists players (id INTEGER PRIMARY KEY AUTOINCREMENT, name string)") %; \
/endif

/def -hLOGIN -iFp{maxpri} _login_hook_1 = \
    /ustaw_gracza ${world_character} %; \
    /set _opoznij_login=1

/def -p21 -q -t'Aby zalogowac sie na istniejaca postac - podaj jej imie.' _login_hook_0 = \
    /if (!_opoznij_login) \
        /def -mregexp -n1 -h'SEND ([^ ]*)' _login_hook_3 = \
            /send %%{P0} %%; \
            /ustaw_gracza $$[tolower({P0})]%%;\
        /unset _opoznij_login%;\
    /endif

/def ustaw_gracza = \
    /mesg Ustawiam gracza: %{*}%; \
    /set _obecny_gracz=%{*} %; \
    /quote -S /shh !mkdir %{TFDIR}/mortal/%{_obecny_gracz} %; \
    /if (_use_sql) \
        /test select("select * from players where name='%{_obecny_gracz}'", "ustaw_gracza_sql") %; \
    /endif

;; ustawia jego globalne id
/def ustaw_gracza_sql = \
    /set _obecny_gracz_id=%{id} %;\
    /mesg Id gracza pobrane: %{id}

; wykona sie, jak nie znajdzie gracza
; dodajemy wpis do bazy
; i ponownie wykonujemy ustaw_gracza_sql z tym samym query
/def ustaw_gracza_sql_empty = \
    /mesg Gracza nie bylo w bazie danych! Dodaje wpis... %; \
    /test query("insert into players (name) values ('%_obecny_gracz') ") %; \
    /test select("select * from players where name='%{_obecny_gracz}'", "ustaw_gracza_sql")

/def -F -mregexp -P0Cgreen -t'(^Ostatnie logowanie:|\.\.\. przywracam polaczenie \.\.\.)' _login_hook_4 = \
    /laduj_konfig

/def laduj_konfig = \
    /if (_obecny_gracz =~ "rindarin") \
        /mesg -i ================================================== %; \
        /mesg -i Obecny gracz: Rindarin, uruchamiam konfig wizarda. %; \
        /mesg -i ================================================== %; \
        /load -q %{TFDIR}/start_rind.tf %; \
;        /loguj_arke %; \
    /elseif (_obecny_gracz =~ "berno") \
        /mesg -i ================================================== %; \
        /mesg -i Obecny gracz: Berno, laduje konfig Nightala. %; \
        /mesg -i ================================================== %; \
        /load -q %{TFDIR}/start_nightal.tf %; \
    /else \
        /mesg -i ================================================== %; \
        /mesg -i Obecny gracz: %{_obecny_gracz}, uruchamiam konfig gracza Arki. %; \
        /mesg -i ================================================== %; \
        /load -q %{TFDIR}/start_arka.tf %; \
        /log off %; \
    /endif
