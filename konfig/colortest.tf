; Nieco przerobiony skrypt testcolor.tf Ken Keys'a,
; Pokazujacy numer rgb
;
; Rind. 19/04/2005 23:13



/if (columns() < 144) \
    /echo Uwaga, beda brzydko widoczne kolory, trzeba miec minimum 144 szerokosci ekranu%;\
/else \
    /if ({wrapsize} != 144) \
	/echo Ustawiam wrapsize na 144 %;\
	/set wrapsize=144%; \
    /endif%;\
/endif %;\

/echo * No to jedziemy!

/echo

/echo * Dla @{Crgb...}

/for _g 0 5 \
    /set _line=@%;\
    /for _r 0 5 \
	/for _b 0 5 \
	    /set _line=%%%_line{Crgb%%%_r%%%_g%%%_b}%%%_r%%%_g%%%_b@{n}|@%%; \
	    /set _line=%%{_line}{n}@%; \
	/echo -p - %{_line}{}


/echo
/echo * Dla @{Cbgrgb...}

/for _g 0 5 \
    /set _line=@%;\
    /for _r 0 5 \
	/for _b 0 5 \
	    /set _line=%%%_line{Cbgrgb%%%_r%%%_g%%%_b}%%%_r%%%_g%%%_b@{n}|@%%; \
	    /set _line=%%{_line}{n}@%;\
        /echo -p - %{_line}{}


/echo Skala szarosci:

/echo * Dla @{Cgray..}

/set _line=@
/for _i 0 23 \
    /set _line=%{_line}{Cgray%_i}%_i@{n}|@
/eval /set _line=%{_line}{}

/eval /echo -p - %{_line}

/echo * Dla @{Cbggray..}

/set _line=@
/for _i 0 23 \
    /set _line=%{_line}{Cbggray%_i}%_i@{n}|@
/eval /echo -p - %{_line}{}

/unset _line

/echo * I 16 zwyklych kolorow systemowych
/echo -p @{Cblack}black@{n}|@{Cred}red@{n}|@{Cgreen}green@{n}|@{Cyellow}yellow@{n}|@{Cblue}blue@{n}|@{Cmagenta}magenta@{n}|@{Ccyan}cyan@{n}|@{Cwhite}white@{n}|
/echo -p @{BCblack}black@{n}|@{BCred}red@{n}|@{BCgreen}green@{n}|@{BCyellow}yellow@{n}|@{BCblue}blue@{n}|@{BCmagenta}magenta@{n}|@{BCcyan}cyan@{n}|@{BCwhite}white@{n}|

/echo W sumie 256 kolorow:)