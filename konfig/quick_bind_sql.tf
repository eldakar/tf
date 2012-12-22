;
; Plik  : quick_bind_sql.tf
; Autor : volus
; Data  : 28/01/2011, 11:42
; Opis  : Biblioteka sqlowa szybkich bindow
;

/bind ` = /eval %_quick_bind

;; standardowo quick_bind to sp
/set _quick_bind=spojrz

;; query do bazy
/if (_use_sql) \
    /test query("create table if not exists quick_binds (id INTEGER PRIMARY KEY AUTOINCREMENT, player_id int, pattern string, bind string)") %; \
/endif

/def quick_bind = \
    /mesg -i QUICK BIND: %{_quick_bind}

/def _zaladuj_bindy = \
    /purge _quick_bind_* %; \
    /test select("SELECT * FROM quick_binds WHERE player_id = %{_obecny_gracz_id}", "_utworz_quick_bind")
    
/def _utworz_quick_bind = \
    /def -F -mregexp -t'%{pattern}' _quick_bind_%{id} = \
	/set _quick_bind=%{bind} %%; \
	/quick_bind


/def dodaj_quick_bind = \
    /let _pattern=%{1} %; \
    /let _bind=%{2} %; \
    /test query("insert into quick_binds (player_id, pattern, bind) values (%{_obecny_gracz_id}, '%{_pattern}', '%{_bind}')") %; \
    /mesg Nowy quick bind dodany. Pattern: "%{_pattern}", binduje komende: %{_bind} %; \
    /_zaladuj_bindy
    
/def usun_quick_bind = \
    /let _id=%{1} %; \
    /test query("delete from quick_binds where id = %{_id}") %; \
    /purge _quick_bind_%{_id} %; \
    /mesg Quick bind o id 1 zostal usuniety
    
/def quick_binds = \
    /test select("SELECT * FROM quick_binds WHERE player_id = %{_obecny_gracz_id}", "_show_quick_bind")
    
/def _show_quick_bind = \
    /mesg ID: %{id}, PATTERN: "%{pattern}", BIND: %{bind}
    


;; ladujemy
/_zaladuj_bindy