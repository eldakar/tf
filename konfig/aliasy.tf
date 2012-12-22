;
; Plik  : aliasy.tf
; Autor : volus
; Data  : 29/03/2006, 15:16:52
; Opis  : Aliasy
;

;;; Mordeczki
/alias :) usmiechnij sie .
/alias :D usmiechnij sie szeroko
/alias :/ skrzyw sie lekko
/alias :> popatrz z usmieszkiem
/alias :] usmiechnij sie lekko
/alias ;] :]
/alias ;) mrugnij lekko

;;; Warlock
/alias zde zdejmij wszystko %; zaloz wszystko

;;; exp!
;;; :PP
;/alias exp \
;    /let _var=$[rand(0,10)] %; \
;    /if (!_var) \
;        /let _gdzie=na wichty %; \
;    /elseif (_var == 1) \
;        /let _gdzie na wsiowe? %; \
;    /elseif (_var == 2) \
;        /let _gdzie=na skaveny? %; \
;    /elseif (_var == 3) \
;        /let _gdzie=na trolle? %; \
;    /elseif (_var == 4) \
;        /let _gdzie=na zbojow? %; \
;    /elseif (_var == 5) \
;        /let _gdzie=na ghule? %; \
;    /elseif (_var == 6) \
;        /let _gdzie=na golemy? %; \
;    /elseif (_var == 7) \
;        /let _gdzie=do ubersreik? %; \
;    /elseif (_var == 8) \
;        /let _gdzie=na grzyboczleki? %; \
;    /elseif (_var == 9) \
;        /let _gdzie=na mutantow? %; \
;    /elseif (_var == 10) \
;        /let _gdzie=na smoka? %; \
;    /else \
;        /let _gdzie=do domu...? %;\
;    /endif %; \
;    powiedz moze pojdziemy %{_gdzie}

;; ladujemy baze aliasow
/eval /load %{DBDIR}/aliasy.tf
