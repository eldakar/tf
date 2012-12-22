; start.tf jest to plik, ktory bedzie odpalal wszystkie dostepne skrypty.
; Jest on loadowany przez .tfrc, wiec na poczatku on _ZAWSZE_ jest odpalany ;]

/def -ag -hREDEF _hide_redef

/load -q funkcje.tf


/load -q tablice.tf
/load -q odmiana.tf

/load -q defs.tf

/load -q aliasy.tf
/load -q bindy.tf


/load -q druzyna.tf

/load -q bufor.tf
/load -q changelog.tf
/load -q dylizans.tf
/load -q highlight.tf
/load -q kondycja.tf
/load -q lazik.tf
/load -q mowa.tf
/load -q pasek.tf
;/load -q ping.tf
/load -q ryby.tf
/load -q sesja.tf
/load -q sprzet.tf
/load -q walka.tf
/load -q wyjscia.tf
/load -q cialo.tf
/load -q ocena_przedmiotu.tf
;/load zapamietywanie.tf <- skrypt dziala, ale jest niekompletny, poza tym nie uzywam
;/load zaslony.tf <- skrypt Sjorvinga, nie uzywam

; kilka definicji, ktorych zabraklo w 'driverze' ;-)
/load -q simul_efuns.tf

; Konfig dla wizardow
;/load wiz.tf <- zmienione w login.tf

; Skrypt, ktory uruchomi odpowiedni konfig
;; przeniesiony do .tfrc
;/load login.tf

; Jesli wchodzimy na Warlocka, to automatycznie odpala sie
; plik ze skryptami do Warlocka :)

/if (_use_sql) \
    /load -q licznik_zabic_sql.tf %; \
/endif 

/load -q welcome.tf

/set sub full
