;
; Plik  : czas_arkowy.tf
; Autor : volus
; Data  : 29/10/2007, 14:49:58
; Opis  : Pokazuje czas arkowy, ktory jest na Arce
;

/set _czas_ark_godziny=00
/set _czas_ark_minuty=00

/def zwroc_czas_arkowy = \
    /echo %{_czas_ark_godziny}:%{_czas_ark_minuty}
    
/set _czas_kolor_dzien=BCgreen
/set _czas_kolor_noc=Cblue

;; wschod/zachod latem          : 4/22
;; wschod/zachod zima           : 8/16
;; wschod/zachod wiosna/jesienia: 6/19

;; stringi gdy dzien:
;;;; nad ranem, po wschodzie slonca; rano; w poludnie; po poludniu; wieczorem
;; string gdy noc
;;;; poznym wieczorem, po zachodzie slonca; w nocy; nad ranem, przed wschodem slonca

