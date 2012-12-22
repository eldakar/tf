;
; Plik  : imiona_sql.tf
; Autor : volus
; Data  : 10/01/2011, 22:15
; Opis  : Skrypt do kolorowania imion z uzyciem bazy danych sqlite
;

;; 
;; create table names (name string, color string)
;;

;; tworzymy tabelke, jesli by jej jeszcze nie mialo byc w naszej bazie
/test query("create table if not exists names (name string, color string)")

/set _kolor_czl=BCwhite
/set _kolor_kra=Cgreen
/set _kolor_hal=Ccyan
/set _kolor_elf=BCgreen
/set _kolor_ogr=Cyellow
/set _kolor_gno=Cblue
/set _kolor_pol=Cmagenta

/def _zaladuj_imiona = \
    /purge _kolor_imie_* %; \
    /test select("select * from names", "_koloruj_imie")

/def _koloruj_imie = \
    /def -F -mregexp -P0%{color} -t'%{name}' _kolor_imie_%{name}

/def _dodaj_imie = \
    /let imie=%{1} %; \
    /let kolor=%{2} %; \
    /test query("insert into names (name, color) values ('%{imie}', '%{kolor}')") %; \
    /_zaladuj_imiona
;    /def -F -mregexp -P0%{kolor} -t'%{imie}' _kolor_imie_%{1}

/def usun_imie = \
    /let imie=%{1} %; \
    /test query("delete from names where name='%{imie}'") %; \
    /undef _kolor_imie_%{imie}

/def imiona = \
    /set _imiona=%;\
    /mesg Zapisane imiona: %; \
    /test select("select * from names order by name asc", "wyswietl_imie") %;\
    /mesg %_imiona
    
/def wyswietl_imie = \
    /set _imiona=%{_imiona} @{%color}%name@{n}


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

/_zaladuj_imiona
