
/def dylizans = \
    /if ({*} =~ NULL) \
	/pecho Dostepne stacje: %; \
	/pecho * kapliczka %; \
	/pecho * wioska nashkel %; \
	/pecho * pod bramami crimmor %; \
	/pecho * beregost %; \
	/return%;\
    /endif %; \
    /pecho Wybrales postoj: %{*}%;\
    /set _dylizans_wysiadka=%{*}
    
/def -F -aCgreen -P1B -mregexp -t'^Z zewnatrz dochodzi twych uszu wolanie woznicy: Dojechalismy! Przystanek (.*)! Mozna wysiadac!' _dylizans_wychodzimy = \
    /if (tolower({P1}) =~ _dylizans_wysiadka) \
	/repeat -2 1 /send wyjscie %; \
    /endif
    
/dylizans nigdzie nie wysiadamy
