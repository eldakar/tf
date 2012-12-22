;
; Plik     : tablice.tf
; Autor    : volus
; Poczatek : 15/09/2005, 17:52:22
; Koniec   :
; Opis     : Biblioteka tablic do tf'a
;

/if ($(/list mesg) =~ NULL) \
    /def mesg = \
        /if (!getopts("iw", "")) /return 0%%; /endif %%; \
        /if ({opt_i}) \
            /test echo(strcat("@{BCgreen}####@{n}", " @{Cyellow}", {*}), "", 1) %%; \
        /elseif ({opt_w}) \
            /test echo(strcat("@{BCgreen}####@{n}", " @{BCred}", {*}), "", 1) %%; \
        /else \
            /test echo(strcat("@{BCgreen}####@{n}", " ", {*}), "", 1) %%; \
        /endif %; \
/endif

/set biblioteka_tablic_wersja=1.2
/set last_update_tablicy=22-06-2006

/def podziel_linie = \
    /let string=%{1}%;\
    /let dlugosc=%{2}%;\
    /if (strlen(str) > {dlugosc}) \
        /mesg -w String ma wiecej znakow niz okreslona ich dlugosc. %; \
        /return %; \
    /endif %; \
    /let dlugosc_bez=$[{dlugosc} - strlen(string)]%; \
    /let dlugosc_bez_podzial=$[expr({dlugosc_bez} / 2)]%; \
    /let string_koncowy=|$[strrep(" ", {dlugosc_bez_podzial})]%{string}$[strrep(" ", {dlugosc_bez_podzial})]|%; \
    /echo -p @{Cgreen}%{string_koncowy}

/def ?array = /array_help

/def array_help = \
    /echo -p @{Cgreen}+$[strrep("-", 78)]+ %; \
    /test podziel_linie("Biblioteka tablic do TF'a,  by volus", 78)%; \
    /test podziel_linie(strcat("Version  ", biblioteka_tablic_wersja), 78)%; \
    /test podziel_linie(strcat("Ostatnia aktualizacja biblioteki: ", last_update_tablicy), 78)%; \
    /echo -p @{Cgreen}|$[strrep(" ", 78)]| %; \
    /echo -p @{Cgreen}|$[strrep(" ", 78)]| %; \
    /echo -p @{Cgreen}|  * /add_array nazwa elem1 elem2 elem3 elem4 ...                              |%; \
    /echo -p @{Cgreen}|         Tworzy tablice nazwana 'nazwa' z elementow 'elem1 elem2' itp.        |%; \
    /echo -p @{Cgreen}|$[strrep(" ", 78)]| %; \
    /echo -p @{Cgreen}|  * /add_index nazwa elem1 elem2 elem4 elem4 ...                              |%; \
    /echo -p @{Cgreen}|         Dodaje element(y) do tablicy 'nazwa'                                 |%; \
    /echo -p @{Cgreen}|$[strrep(" ", 78)]| %; \
    /echo -p @{Cgreen}|  * /sizeof_array nazwa                                                       |%; \
    /echo -p @{Cgreen}|         Zwraca ilosc elementow tablicy 'nazwa'                               |%; \
    /echo -p @{Cgreen}|$[strrep(" ", 78)]| %; \
    /echo -p @{Cgreen}|  * /check_index nazwa nr_indeksu                                             |%; \
    /echo -p @{Cgreen}|         Zwraca wartosc 'nr_indeksu' z tablicy 'nazwa'                        |%; \
    /echo -p @{Cgreen}|$[strrep(" ", 78)]| %; \
    /echo -p @{Cgreen}|  * /member_array elem tablica                                                |%; \
    /echo -p @{Cgreen}|         Sprawdza, czy 'elem' jest elementem tablicy 'tablica'                |%; \
    /echo -p @{Cgreen}+$[strrep("-", 78)]+

;/def if_array_exists = \
;    /if ($(/listvar -v _array_%{*})) \
;        /result 1%; \
;    /endif

/def if_array_exists = \
    /if ($(/eval /echo %%_array_%{*}) !~ NULL) \
        /result 1%; \
    /else \
        /result 0%; \
    /endif

/def add_array = \
    /if ({#} < 2) \
        /mesg -i Musisz podac nazwe tablicy i przynajmniej jeden jej element %; \
        /mesg -i Np: /add_array druzyna jarek marek franek%; \
        /return %; \
    /endif %; \
    /if (regmatch("[()|]", {*})) \
        /mesg -i Nazwa tablicy oraz elementy nie moga miec w sobie znakow '(', ')', oraz '|'.%; \
        /mesg -w Uwaga! 1 element liczony jest jako 1 wyraz, liczba badz litera!%; \
        /mesg -w Wiec spacja liczona jest jako koniec elementu tablicy.%; \
        /return %; \
    /endif %; \
    /set _array_%{1}=$[replace(" ", "|", {-1})]|

/def add_index = \
    /if ({#} < 2) \
        /mesg -i Musisz podac nazwe tablicy i przynajmniej jeden jej element do dodania.%; \
        /mesg -i Np: /add_index druzyna krzysztof%; \
        /mesg -i Doda 'krzysztof' do tablicy 'druzyna'%; \
        /return %; \
    /endif %; \
    /if (regmatch("[()|]", {*})) \
        /mesg -i Nazwa tablicy oraz elementy nie moga miec w sobie znakow '(', ')', oraz '|'.%; \
        /return %; \
    /endif %; \
    /if (if_array_exists({1})) \
        /set _array_%{1}=$(/eval /echo %%_array_%{1})$[replace(" ", "|", {-1})]|%;\
    /else \
        /mesg -w Tablica '%{1}' nie istnieje!%; \
    /endif

/def sizeof_array = \
    /if ({#} < 1) \
        /mesg -i Musisz podac nazwe tablicy.%; \
        /mesg -i Np: /sizeof_array druzyna%; \
        /return %; \
    /endif %; \
    /if (if_array_exists({1})) \
        /let PomocniczaZmienna=$(/eval /echo %%_array_%{1})%; \
        /let tab=$[replace("|", " ", {PomocniczaZmienna})]%; \
        /let wynik=$(/policz_tablice %{tab})%; \
        /echo %{wynik} %; \
    /else \
        /mesg -w Nie ma tablicy nazwanej '%{1}'. %; \
    /endif

/def policz_tablice = \
;    /let k_z=0%; \
;    /while ({#}) \
;        /test ++k_z%; \
;        /shift %; \
;    /done %; \
    /result %{#}

/def check_index = \
    /if ({#} != 2) \
        /mesg -i Musisz podac nazwe tablicy oraz numer indeksu, jaki mam sprawic. %; \
        /mesg -i Jesli podasz indeks '0', Wyswietle wszystkie elementy. %; \
        /return %; \
    /endif %; \
    /if (if_array_exists({1})) \
        /let rozmiar_tablicy=$(/policz_tablice $[replace("|", " ", $(/eval /echo %%_array_%{1}))])%; \
        /if ({2} < 0) \
            /mesg -w Indeks musi byc wiekszy od 0. Jesli chcesz abym wyswietlil wszystkie elementy %; \
            /mesg -w Podaj 0 jaki drugi argument%; \
            /return %; \
        /elseif ({2} != 0 & {2} > {rozmiar_tablicy}) \
            /mesg -w Indeks wykracza poza tablice! Ta tablica ma %{rozmiar_tablicy} elementow!%; \
            /return %; \
        /endif%; \
        /if ({2} == 0) \
            /pokaz_wszystkie_indeksy_tablicy $[replace("|", " ", $(/eval /echo %%_array_%{1}))]%; \
        /else \
            /pokaz_indeks %{2} %{1} $[replace("|", " ", $(/eval /echo %%_array_%{1}))]%; \
        /endif %; \
    /else \
        /mesg -w Nie ma takiej tablicy '%{1}'!%; \
    /endif

/def pokaz_wszystkie_indeksy_tablicy = \
    /let i_t=0%; \
    /while ({#}) \
        /test ++i_t%; \
        /echo %{i_t}: %{1}%; \
        /shift %; \
    /done

/def pokaz_indeks = \
    /let _nr=%{1}%; \
    /let _ta=%{2}%; \
    /shift %{1}%; \
    /shift %; \
    /echo %{1}
;    /echo Index %{_nr} of an array '%{_ta}' is '%{1}'

/def member_array = \
    /let _ind=%{1}%; \
    /let _arr=%{2}%; \
    /if (if_array_exists(_arr)) \
	/let _var_arr=$(/eval /echo %%_array_%{_arr}) %; \
;	/echo %_var_arr %;\
        /if (regmatch(strcat(_ind, "\|"), _var_arr)) \
	    /result 1 %; \
        /else \
	    /result 0 %; \
        /endif %; \
    /else \
        /mesg -w Tablica '%_arr' nie istnieje!%; \
    /endif


/def remove_index =\
    /let _arr=%{1}%; \
    /let _ind=%{2}%; \


; Tak usuwamy pierwszy element...
; /echo $[substr(_array_odmiana_elf, strchr(_array_odmiana_elf, "|") + 1)]

; A tak pozostale:
; /let _lewa=%; \
; /let _pom=$(/eval /echo _array_%_arr)%; \
; /for i 0 (_ind -1)\
;   /let _pom=$[substr(_pom, strchr(_pom, "|") + 1)]
;   /let _lewa=%{_lewa}%{_pom}%;\
;   /let _co_wyciac=$[substr(_array_odmiana_elf, strchr(_array_odmiana_elf, "|") + 1)]

; Ehh, kupa roboty z tym jest. Nie chce mi sie :P

;/def remove_index = \     <--- Stare i brzydko wyrzuca :|
;   /let _arr=%{1}%; \
;   /let _ind=%{2}%; \
;   /if (if_array_exists(_arr)) \
;       /let _inx=$(/check_index %_arr %_ind)|%; \
;       /echo %_inx%; \
;       /let _pz=$(/eval /echo %%_array_%{_arr})%; \
;       /let _pz=$[replace(_inx, "", _pz)]%; \
;       /set _array_%_arr=%_pz%; \
;       /echo Element '$[replace("|", "", _inx)]' zostal usuniety z tablicy '%_arr'.%; \
;   /else \
;       /mesg -w Tablica '%_arr' nie istnieje!%; \
;   /endif

; /remove_index name nr_of_index
; Not implemented yet :)