;
; Plik  : statystyka.tf
; Autor : volus
; Data  : 26/10/2007, 00:59:39
; Opis  : Tabele, statystyki itp
;

/def ciosy = \
    /echo -p @{Cgreen} +----------------------+---------+-----------+ %; \
    /echo -p @{Cgreen} | Typ ciosu            |  Ilosc  |  Procent  | %; \
    /echo -p @{Cgreen} +----------------------+---------+-----------+ %; \
    /echo -p @{Cgreen} | Ledwo muskasz        |$eval [_divide_line(_stat_cios_ledmus, 10, "|", 2)] %; \
    /echo -p @{Cgreen} | Bardzo ciezko ranisz |