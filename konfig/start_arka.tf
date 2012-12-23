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

/eval /set ArkaDir=%{TFDIR}/mortal/%{_obecny_gracz}

/eval /cd %{ArkaDir}

/if (file_exists(strcat(ArkaDir, "/start.tf"))) \
  /load start.tf %; \
/else \
  /eval /pecho start.tf file for player %_obecny_gracz not found in %{TFDIR}/mortal/%{_obecny_gracz}/, not loading %; \
/endif

;; ze sprzet.tf
/zaladuj_sprzet
