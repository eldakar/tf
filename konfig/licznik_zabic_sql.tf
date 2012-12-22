;
; Plik  : licznik_zabic_sql.tf
; Autor : volus
; Data  : 22/02/2011, 19:35
; Opis  : licznik zabic w sql
;
;

/if (_use_sql) \
    /test query("create table if not exists kills (id INTEGER PRIMARY KEY AUTOINCREMENT, player_id int, monster string, quantity int)") %; \
/endif

/def -Fp19 -mregexp -t'^Zabil[ae]s (.*)\.$'	_sql_killed = \
    /let _ofiara=$(/last %{P1}) %; \
    /test select("select * from kills where monster = '%{_ofiara}' and player_id = '%{_obecny_gracz_id}'", "_licznik_zabic_increment_kill")
    
/def _licznik_zabic_increment_kill = \
    /let _count=%{quantity} %; \
    /test ++_count %; \
    /repeat -1 1 /test query("update kills set quantity = '%{_count}' where id = '%{id}'")
    
/def _licznik_zabic_increment_kill_empty = \
    /test query("insert into kills (player_id, monster, quantity) values ('%{_obecny_gracz_id}', '%{_ofiara}', '0')") %; \
    /test select("select * from kills where monster = '%{_ofiara}' and player_id = '%{_obecny_gracz_id}'", "_licznik_zabic_increment_kill")
    
/def kills = \
    /set _sql_debug=0 %; \
    /echo -p $[strcat("+", strrep("-", 18), "+")]------+ %; \
    /echo -p | @{BCgreen}Ofiara (ogolnie)@{n} | @{BCyellow}SUMA@{n} | %; \
    /echo -p $[strcat("+", strrep("-", 18), "+")]------+ %; \
    /test select("SELECT * FROM kills WHERE player_id = '%{_obecny_gracz_id}'", "_licznik_zabic_wyswietl_ofiare") %; \
    /echo -p $[strcat("+", strrep("-", 18), "+")]------+ %; \
    /test select("SELECT SUM(quantity) AS suma FROM kills WHERE player_id = '%{_obecny_gracz_id}'", "_licznik_zabic_wyswietl_sume") %; \
    /echo -p $[strcat("+", strrep("-", 18), "+")]------+ %; \
    /set _sql_debug=1
    
    
/def _licznik_zabic_wyswietl_ofiare = \
    /let _ofiara=$[decode_attr(strcat("@{B}", monster))] %; \
    /let _wartosc=%{quantity} %; \
    /echo -p |$[pad(_ofiara, 17)] |$[pad(_wartosc, 4)]  |
    
/def _licznik_zabic_wyswietl_sume = \
    /echo -p |           @{BCgreen}Ogolem@{n} |$[pad(suma, 4)]  |