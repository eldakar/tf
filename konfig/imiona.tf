;
; Plik  : imiona.tf
; Autor : volus
; Data  : 03/11/2007, 17:10:27
; Opis  : Skrypt do kolorowania imion
;

/set _kolor_czl=BCwhite
/set _kolor_kra=Cgreen
/set _kolor_hal=Ccyan
/set _kolor_elf=BCgreen
/set _kolor_ogr=Cyellow
/set _kolor_gno=Cblue
/set _kolor_pol=Cmagenta

/def _dodaj_imie = \
    /let imie=%{1} %; \
    /let kolor=%{2} %; \
    /def -F -mregexp -P0%{kolor} -t'%{imie}' _kolor_imie_%{1}

/def dodaj_czlowieka = \
    /test _dodaj_imie({1}, _kolor_czl)

/def dodaj_krasnoluda = \
    /test _dodaj_imie({1}, _kolor_kra)
    
/def dodaj_halflinga = \
    /test _dodaj_imie({1}, _kolor_hal)
    
/def dodaj_elfa = \
    /test _dodaj_imie({1}, _kolor_elf)
    
/def dodaj_ogra = \
    /test _dodaj_imie({1}, _kolor_ogr)
    
/def dodaj_gnoma = \
    /test _dodaj_imie({1}, _kolor_gno)
    
/def dodaj_polelfa = \
    /test _dodaj_imie({1}, _kolor_pol)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/purge _kolor_imie_*

/dodaj_halflinga celith
/dodaj_gnoma jako
/dodaj_polelfa seren
/dodaj_elfa vayneele
/dodaj_halflinga noir
    