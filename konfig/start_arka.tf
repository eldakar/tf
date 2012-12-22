;
; Plik  : start_arka.tf
; Autor : volus
; Data  : 16/10/2006, 13:57:59
; Opis  : Skrypt startujacy konfiguracje dla gracza Arkadii
;

;; mamy juz id gracza, ladujemy quick_binds, jeżeli używamy sql
/if (_use_sql) \
    /load quick_bind_sql.tf %; \
/endif

/eval /set ArkaDir=$(/pwd)/mortal/%{_obecny_gracz}/

/eval /cd %{ArkaDir}

/load start.tf

