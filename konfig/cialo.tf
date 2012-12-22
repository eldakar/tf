;
; Plik  : cialo.tf
; Autor : volus
; Data  : 19/02/2011, 22:33:24
; Opis  : 
;


/def -F -mregexp -t'^Jest to martwe cialo (.*)\.' _cialo_catch_sprzet = \
    /set _cialo=%{P1} %; \
    /def -F -1 -mregexp -t'^Zauwazasz przy (nim|niej) (.*)\.' _cialo_process_sprzet = \
	/let _sprzet=%%{P2} %%; \
	/_cialo_show_sprzet %%_sprzet %%; \
	/repeat -0 1 /purge _cialo_process_sprzet
	
	
/def _cialo_show_sprzet = \
    /let _sprzet=$[replace(", ", "|", replace(" i ", "|", _sprzet))] %; \
    /let _sprzet=$[replace(" ", "_", _sprzet)] %; \
    /let _sprzet=$[replace("|", " ", _sprzet)] %; \
    /_cialo_show_sprzet_item %_sprzet
    
;    /quote -S `/_cialo_show_sprzet_item %_sprzet
    
/def _cialo_show_sprzet_item = \
    /let _iterator=1 %; \
    /while ({#}) \
	/let _item=$[replace("_", " ", {1})] %; \
	/let _item=$[replace("wiele ", "1000 ", _item)] %; \
	/pecho (%_iterator) @{BCwhite}%_item@{n} %; \
	/set _cialo_rzecz_%_iterator=%_item %; \
	/test ++_iterator %; \
	/shift %; \
    /done
    
/def wez = \
    /eval wez %%_cialo_rzecz_%1 z ciala $[tolower(_cialo)]
    
    