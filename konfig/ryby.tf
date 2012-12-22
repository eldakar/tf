;
; Plik  : ryby.tf
; Autor : volus
; Data  : 16/10/2007, 18:21:55
; Opis  : 
;

/set _przewaga=0
/set _proby=0

/def -F -aBCwhite -mregexp -t'wedki napina sie!' _wedka_napina = \
    /set _przewaga=0%; \
    /set _proby=0%; \
    /tmpbind zatnij rybe na wedce %;\
    /beep

/def -F -aBCwhite -mregexp -t'Wyciagasz zlapana rybe na powierzchnie' _wedka_wyciagam_rybe = \
    /tmpbind /key_f5 %; \
    /beep
    
/def -F -aBCwhite -mregexp -t'Sznurek.*opada swobodnie na wode, zapewne' _wedka_odpadla = \
    /tmpbind /key_f3 %%; /key_f4 %%; zarzuc wedke %; \
    /beep
    
/def -F -aBCyellow -mregexp -t'Udaje ci sie przyciagnac rybe do siebie' _przewaga_udaje = \
    /test ++_przewaga %; \
    /test ++_proby %; \
    /if (_przewaga > 0) \
        /substitute -p %{PL}%{P0}%{PR} (+%{_przewaga}/%{_proby}) %; \
    /else \
        /substitute -p %{PL}%{P0}%{PR} (%{_przewaga}/%{_proby}) %; \
    /endif
    
/def -F -aCyellow -mregexp -t'Zlapana na wedke ryba zdobywa nad toba chwilowa przewage' _przewaga_nie_udaje = \
    /test --_przewaga %; \
    /test ++_proby %; \
    /if (_przewaga > 0) \
        /substitute -p %{PL}%{P0}%{PR} (+%{_przewaga}/%{_proby}) %; \
    /else \
        /substitute -p %{PL}%{P0}%{PR} (%{_przewaga}/%{_proby}) %; \
    /endif
    
    