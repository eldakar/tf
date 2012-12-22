;
; Plik     : pasek.tf
; Autor    : volus
; Poczatek : 20/10/2005, 11:16:51
; Koniec   :
; Opis     : Pasek :)
;

; Na poczatek :-)
/status_defaults

/set status_height=1
/set warn_status=off

/set status_fields=
/set status_pad=

/status_add :3
/status_add " Swiat: ":8:Cgreen @world:10:BCyellow " Czas: ":7:Ccyan @clock:5:BCgreen
/status_add " Borg: ":7:BCwhite borg:3:Cgreen

/status_add "Tell: ":6:BCwhite _who_last_tell:14:Cyellow

;/status_add -r1 :3
;/status_add -r1 " Ping: ":7:BCwhite _lag:10 

/status_save

/def -h'RESIZE'	_status_hook = \
    /repeat -0.5 1 /status_restore %;\
    /set wrapsize=$[columns()]

