;
; Plik: db.tf
; Autor: volus
; Data: 2011-01-10, 22:47:00
; 

;
; Uzycie bazy danych.
;
; Aktualnie sa tylko 2 funkcje: query i select
; 
; QUERY
; Za pomoca tej funkcji manewrujemy klauzali
; INSERT, DELETE, UPDATE
;
; Przyklady uzycia:
; /test query("INSERT INTO players (name) values ('gracz')")
;
; /test query("DELETE FROM players WHERE age > 20")
;
; Funkcja nie zwroci nam zadnej wartosci
;
; SELECT
; Sluzy do pobierania danych z bazy oraz do manewrowania nimi
; Funkcja ma 2 argumenty. 1 z nich to zapytanie SQL, drugim
; argumentem jest nazwa funkcji jaka ma sie wykonac przy iteracji
; kazdego wyciagnietego wiersza z bazy
; /test query(SQL_QUERY, CALLBACK)
;
; Przyklad:
; /test query("SELECT * FROM players", "info_o_graczu")
;
; /def info_o_graczu = \
;   /echo Imie: %imie %;\
;   /echo Wiek: %age
;
; Ten def info_o_graczu bedzie sie wykonywal tyle razy ile
; Zwroci nam rekordow powyzsze zapytanie. Wewnatrz tego
; defa bedziemy mieli zmienne lokalne, nazwane po kolumnach
; w danej tabeli. Czyli jezeli nasza tabela players ma dwie kolumny:
; 'imie' oraz 'age', no to wlasnie te zmienne lokalne otrzymamy
;
; W przypadku, gdy zapytanie nie zwroci nam zadnego rekordu, wtedy
; wykona sie funkcja o nazwie CALLBACK_empty (w tym przypadku info_o_graczu_empty)
; (nie musi ona byc zadeklarowana, jezeli biblioteka ja znajzie, 
; to ja wykona. przyklad uzycia z funkcja empty mozna znalezc w 
; skrypcie login.tf w funkcji /ustaw_gracza)
;
; /def info_o_graczu_empty = \
;   /echo Nie znalazlem zadnych graczy.
;

/require stack-q.tf

/eval /set SQLFILE=%{TFDIR}/tf.db

/set _use_sql=1
/set _sql_debug=1 

/def query = \
;    /echo otwieram query %; \
    /let _sql=%{1} %; \
    /if (_sql_debug) \
        /echo SQL: %{_sql} %; \
    /endif %; \
    /if (sql_connection := dbopen({SQLFILE})) \
	/test push(sql_connection, "c_db") %; \
	/let _c=$(/pop c_db) %; \
	/if (sql_statement := dbprepare(_c, _sql)) \
	    /test push(sql_statement, "s_db") %; \
	    /let _st=$(/pop s_db) %; \
	    /test dbstep(_st) %; \
	    /test dbfinalize(_st) %; \
	/endif %; \
    /endif %; \
    /test dbclose(_c)
;    /echo zamykam query
	
    
/def select = \
;    /echo otwieram select %; \
    /let _sql=%{1} %; \
    /if (_sql_debug) \
        /echo SQL: %{_sql} %; \
    /endif %; \
    /let _callback=%{2} %; \
    /let _empty=1 %; \
    /if (sql_connection := dbopen({SQLFILE})) \
	/test push(sql_connection, "c_db") %; \
	/let _c=$(/pop c_db) %; \
	/if (sql_statement := dbprepare(_c, _sql)) \
	    /test push(sql_statement, "s_db") %; \
	    /let _s=$(/pop s_db) %; \
	    /while (dbstep(_s) == 0) \
		/let _empty=0 %; \
		/%_callback %; \
	    /done %; \
	    /test dbfinalize(_s) %; \
	    /if (_empty) \
		/if ($(/list %{_callback}_empty) !~ NULL) \
		    /%{_callback}_empty %; \
		/endif %; \
	    /endif %; \
	/endif %;\
    /endif %; \
    /test dbclose(_c)
;    /echo zamykam select
