;
; Plik  : sesja.tf
; Autor : volus
; Data  : 28/03/2007, 00:23:51
; Opis  : plik ktory pokaze tabelke zabic w danej sesji mudowej
;
;   opis:   bardzo stary skrypt, zrobiony jeszcze ze starym konfigiem
;           co prawda dziala, ale cholernie wolno. trzeba go zaktualizowac
;           a nie chce mi sie :P
;
; Aktualizacja 04/11/2007
; W tym pliku bedzie rowniez sesja zabic
;

/def _init_licznik = \
    /eval /set _zapis_licznik=%{TFDIR}/mortal/%{_obecny_gracz}/licznik.d

/def zapisz_licznik = \
    /if (!getopts("q", "")) \
        /return 0 %; \
    /endif %; \
    /if ((uchwyt := tfopen(_zapis_licznik, "w")) < 0) \
        /return 0 %; \
        /mesg -w Nie moge otworzyc pliku %{_zapis_licznik} do zapisu!! %; \
    /endif %; \
    /test tfflush(uchwyt, 0) %; \
    /doeach /zapisz_ofiare $(/listvar -s _licznik_*) %; \
    /test tfclose(uchwyt) %; \
    /if (!opt_q) \
        /mesg Dane licznika ofiar zapisane zostaly do pliku %{_zapis_licznik}%;\
    /endif
 
/def zapisz_ofiare = \
    /test tfwrite(uchwyt, strcat({1}, " ", $(/listvar -v %{1})))
    
/def wczytaj_licznik = \
    /if ((uchwyt := tfopen(_zapis_licznik, "r")) < 0) \
        /return 0 %; \
        /mesg -w Nie moge otworzyc pliku %{_zapis_licznik} do odczytu! %; \
    /endif %; \
    /while (tfread(uchwyt, tmp) >= 0) \
        /let _ofiara=$[substr(tmp, 0, strchr(tmp, ' '))] %; \
        /let _wartos=$(/last %{tmp}) %; \
        /set %{_ofiara}=%{_wartos} %; \
    /done %; \
    /test tfclose(uchwyt) %; \
    /mesg Dane licznika ofiar zostaly pomyslnie wczytane z pliku %{_zapis_licznik}
    
/def -Fp10 -mregexp -t'^(> |)Zabil[ae]s (.*)\.$'                  _zabilem2 = \
    /ustaw_kto_zabil JA %; \
    /ustaw_kogo_zabil %{P2} %; \
    /let _ofiara=$(/last %{P2}) %; \
    /test ++_licznik_%{_ofiara} %; \
    /eval /substitute -p @{BCcyan}===] @{nBCgreen}TY @{nCbgred,BCcyan}ZABILES@{nBCyellow} %{P2} @{nCgreen}(%%{_liczniksesja_JA_%{_ofiara}}/%%{_licznik_%{_ofiara}}) @{nBCcyan}[===%; \
    /if (_zapis_licznik !~ NULL) \
        /zapisz_licznik -q %; \
    /endif

/def -Fp10 -mregexp -t'^(.+?) (?:\\(.*\\) |)zabil(?:a|o|) (.+)\\.$'         _ktos_zabil = \
    /ustaw_kto_zabil  %{P1} %; \
    /ustaw_kogo_zabil %{P2} %; \
    /substitute -p @{BCcyan}===] @{nCgreen}%{P1} @{nCbgred,BCcyan}>> OWNED >>@{nBCyellow} %{P2} @{nBCcyan}[===

/def ustaw_kto_zabil = \
    /set kto_zabil=$[substr({L1}, 0, 14)]

/def ustaw_kogo_zabil = \
    /set kogo_zabil=$[substr({L1}, 0, 13)]      %; \
    /test ++_ile_fragow_%{kto_zabil}            %; \
    /test ++_liczniksesja_%{kto_zabil}_%{kogo_zabil}    %; \
    /test ++_liczba_zgonow_%{kogo_zabil}        %; \
;    /eval /echo -p @{BCgreen}%{kto_zabil}@{nCgreen} ma juz @{BCgreen}%%{_ile_fragow_%kto_zabil}@{nCgreen} fragow!

/def wyswietl_ofiare = \
    /let _ofiara=$[decode_attr(strcat("@{B}", substr({1}, 9)))] %; \
    /let _wartosc=$(/listvar -v %{1}) %; \
    /echo -p |$[pad(_ofiara, 17)] |$[pad(_wartosc, 4)]  |

/def podlicz_ofiary2 = \
    /set _ofiary_ogolem=$[_ofiary_ogolem + {1}]

/def podlicz_ofiary = \
    /set _ofiary_ogolem=0%;\
    /quote -S /podlicz_ofiary2 `/listvar -v _licznik_*

/def zabici = \
    /podlicz_ofiary %; \
    /echo -p $[strcat("+", strrep("-", 18), "+")]------+ %; \
    /echo -p | @{BCgreen}Ofiara (ogolnie)@{n} | @{BCyellow}SUMA@{n} | %; \
    /echo -p $[strcat("+", strrep("-", 18), "+")]------+ %; \
    /quote -S /wyswietl_ofiare `/listvar -s _licznik_* %; \
    /echo -p $[strcat("+", strrep("-", 18), "+")]------+ %; \
    /echo -p |           @{BCgreen}Ogolem@{n} |$[pad(_ofiary_ogolem, 4)]  | @{nBCgreen}<@{nBCyellow}<@{nBCmagenta}<@{nBCblue}<@{nBCwhite}<%; \
    /echo -p $[strcat("+", strrep("-", 18), "+")]------+ %; \
    
/def dodaj_duzo_danych = \
    /for i 1 10 \
        /itrigger Daggerro zabil wielkiego krasnoluda. %; \
    /for i 1 12 \
        /itrigger Wielki elf zabil malego wilka. %; \
    /for i 1 15 \
        /itrigger Mistrz zabil smoka. %; \
    /for i 1 17 \
        /itrigger Kunegunda zabila niedzwiedzia. %; \
    /for i 1 19 \
        /itrigger Halfling zabil starego czlowieka. %; \
    /for i 1 21 \
        /itrigger Mieczyslaw zabil Joanne. %; \
    /for i 1 45 \
        /itrigger Smok zabil elfa. %; \
    /for i 1 10 \
        /itrigger Qwe zabil asd. %; \
    /for i 1 12 \
        /itrigger Asd zabil zxc. %; \
    /for i 1 15 \
        /itrigger Qwepok zabil qpwoek. %; \
    /for i 1 15 \
        /itrigger ASdzxczx zabil gnoma. %; \
    /for i 1 15 \
        /itrigger ASdqwes zabil zwierzoczleka. %; \
    /for i 1 15 \
        /itrigger Aasdasdas zabil kogostam. %; \

/def tod = \
    /set linia1=$[strcat("+", strrep("-", 16), "+")]%; \
    /set linia2=| @{BCgreen}Today's kills@{n}  |%; \
    /set summary=| @{BCgreen}        Ogolem@{n} | %; \
    /remove_array killers %; \
    /create_empty_array killers %; \
    /quote -S /create_header `/listvar -s _ile_fragow_* %; \
    /set linia1=%{linia1}----+%; \
    /set linia2=%{linia2}@{BCyellow}SUMA@{n}|%; \
    /eval /echo %{linia1}%; \
    /eval /echo -p %{linia2}%; \
    /eval /echo %{linia1}%; \
    /quote -S /show_specific_killers `/listvar -s _liczba_zgonow_* %; \
    /eval /echo %{linia1}%; \
    /set summary=%{summary}$[pad("@{BCwhite}", 10, {_ile_s}, 3, "@{n}", 4, "|", 2)]%;\
    /echo -p %{summary} %;\
    /eval /echo %{linia1}%; \
    /unset __tmp%; \
    /unset __tmp2%; \
    /unset __temp%; \
    /unset __temp2%; \
    /unset _ile_s

/def create_header = \
    /test regmatch("_ile_fragow_([^_]*)", {1}) %; \
    /let _name=%{P1} %; \
    /set linia2=%{linia2}@{Cbgblue,BCwhite}%{_name}@{n}|%; \
    /set linia1=%{linia1}$[strrep("-", strlen(_name))]+ %; \
    /let _ile=$(/listvar -v %{1}) %;\
    /set _ile_s=$[_ile_s + _ile] %; \
    /let _dl1=$[strlen(_name) / 2 + 1] %; \
    /let _dl2=$[strlen(_name) - (strlen(_name) / 2 + 1) + 1] %; \
    /set summary=%{summary}$[pad("@{BCwhite}", 10, {_ile}, {_dl1}, "@{n}", 4, "|", {_dl2})] %; \
    /add_index killers %_name

/def show_specific_killers = \
    /test regmatch("_liczba_zgonow_([^_]*)",{1})%;\
    /set _nazwa=%{__tmp}%; \
    /set __tmp=%{P1}%; \
    /let _kogo=%{P1}%; \
    /let _ile=$(/listvar -v %{1})%; \
    /if ({_nazwa} !~ {_kogo}) \
        /if ({_nazwa} !~ {__tmp}) \
            /set _nazwa=%{P1}%; \
        /endif %; \
        /set linia=| $[pad({_nazwa},14)] |%; \
    /endif%; \
    /array_each killers /@eval \
        /let killer_name %%_val %%; \
        /let umc=$$(/listvar -s _liczniksesja_%%{killer_name}_%{_kogo}) %%; \
        /if (umc =~ NULL) \
            /set _liczniksesja_%%{killer_name}_%{_kogo}=-%%; \
        /endif %%; \
        /let _value=$$(/listvar -v _liczniksesja_%%{killer_name}_%{_kogo}) %%; \
        /let ddlugosc=$$[strlen(killer_name)] %%; \
        /let ddlugosc2=%%{ddlugosc} %%; \
        /let ddlugosc=$$[{ddlugosc} / 2 + 1] %%; \
        /let ddlugosc2=$$[{ddlugosc2} - {ddlugosc} + 1] %%; \
        /set linia=%%{linia}$$[pad("@{BCwhite}", 10, {_value}, {ddlugosc}, "@{n}", 4, "|", {ddlugosc2})] %; \
    /set linia=%{linia}$[pad("@{BCgreen}",10,{_ile},3)]@{n} |%; \
    /echo -p %{linia}
