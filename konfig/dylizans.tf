;
; Plik  : dylizans.tf
; Autor : volus
; Data  : 05/11/2007, 16:33:24
; Opis  : Automatyczne wysiadanie na wskazanym przez nas postoju dylizansu.
;

/set _wysiadka=nigdzie

/def dylizans = \
    /if ({*} =~ null) \
        /pecho Wysiadamy na przystanku: %{_wysiadka} %; \
        /return %; \
    /endif %; \
    /if ({*} =~ "lista") \
        /wyswietl_liste_przystankow %; \
        /return %; \
    /endif %; \
    /if ({1} > 0) \
        /ustaw_przystanek %{1} %; \
        /return %; \
    /else \
        /pecho Uzycie: %; \
        /pecho * /dylizans - pokazuje aktualnie ustawiony przystanek %; \
        /pecho * /dylizans lista - pokaze nam liste dostepnych przystankow %; \
        /pecho * /dylizans 2 - ustalamy, ze wysiadamy na przystanku nr 2 w/w listy %; \
    /endif

/def wyswietl_liste_przystankow = \
    /pecho +---- linia @{BCwhite}Nuln -> Salignac@{n} %; \
    /pecho | 1) Nuln %; \
    /pecho | 2) Kreutzhofen %; \
    /pecho | 3) Karczma 'Pod piegowata elfka' %; \
    /pecho | 4) Salignac La Rouge %; \
    /pecho +---- linia @{BCwhite}Nuln -> Kraina Zgromadzenia@{n} %; \
    /pecho | 5) Nuln %; \
    /pecho | 6) Bissingen %; \
    /pecho | 7) Kraina Zgromadzenia %; \
    /pecho +---- linia @{BCwhite}Nuln -> Jouinard@{n} %; \
    /pecho | 8) Nuln %; \
    /pecho | 9) Uberserik %; \
    /pecho |10) Bogenhafen %; \
    /pecho |11) Jouinard %; \
    /pecho +----------------------------------
    
/def ustaw_przystanek = \
    /if ({1} == 1) \
        /set _wysiadka=Postoj, niewielki plac w poludniowej czesci miasta.%;\
    /elseif ({1} == 2) \
        /set _wysiadka=Postoj, placyk w centrum miasteczka Kreutzhofen.%;\
    /elseif ({1} == 3) \
        /set _wysiadka=Postoj, dziedziniec przed zajazdem 'Pod piegowata elfka'.%;\
    /elseif ({1} == 4) \
        /set _wysiadka=Postoj, rynek miejski Salignac La Rouge.%;\
    /elseif ({1} == 5) \
        /set _wysiadka=Postoj, placyk w polnocnej czesci miasta.%;\
    /elseif ({1} == 6) \
        /set _wysiadka=Postoj, maly Rynek w Bissingen.%; \
    /elseif ({1} == 7) \
        /set _wysiadka=Postoj, dziedziniec frontowy karczmy.%; \
    /elseif ({1} == 8) \
        /set _wysiadka=Postoj, ulica.%; \
    /elseif ({1} == 9) \
        /set _wysiadka=Postoj, przed zajazdem 'Pod Srebrnym Grotem'.%; \
    /elseif ({1} == 10) \
        /set _wysiadka=Postoj, rynek przy fontannie.%; \
    /elseif ({1} == 11) \
        /set _wysiadka=Postoj, placyk z fontanna.%; \
    /endif %; \
    /update_dylizansu %; \
    /pecho Ok, wiec wysiadamy tu: %{_wysiadka}
    
/def update_dylizansu = \
    /def -F -mregexp -1 -P0BCwhite -t'$(/escape .' %{_wysiadka})' _dylizans_out = \
        /repeat -1 1 wyjscie %%; \
        /set _wysiadka=nigdzie
        