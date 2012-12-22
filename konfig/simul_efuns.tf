;
; Plik  : simul_efuns.tf
; Autor : volus
; Data  : 27/09/2006, 01:11:33
; Opis  : w tym pliku mamy pewne funkcje, ktorych zabralo w oryginalnym
;         tf-libie Ken Keysa
;

/def -i secho = /~do_prefix s %*

; automatycznie dodaje spacje na koncu... przynajmniej powinno :|
/def -i qprefix = /~do_echoprefix q %*
/def -i mprefix = /~do_echoprefix m %*
/def -i kprefix = /~do_echoprefix k %*
/def -i sprefix = /~do_echoprefix s %*

/def -i ~do_echoprefix = \
    /set %{1}prefix=%{-1}

