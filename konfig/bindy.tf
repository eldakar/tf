;
; Plik     : bindy.tf
; Autor    : volus
; Poczatek : 19/10/2005, 21:10:16
; Koniec   :
; Opis     : Plik z glownymi bindami (uzywane od tf 5.0 b7)
;

; Ostatnia modyfikacja: 2 XI 2005
; Ostatnia modyfikacja: 7 VI 2006 (poprawienie funkcji _check_go)

;;; Chodzenie zwykle, przemykanie sie i przemykanie z druzyna

;/def _check_go = \
;    /if ({2} != 0) \
;        /let _m1=Przemykasz sie %; \
;        /let _c1=przemknij %; \
;        /if ({3} != 0) \
;            /let _m2=z druzyna na %; \
;            /let _c2=z druzyna %; \
;        /else \
;            /let _m2=na %; \
;        /endif %; \
;    /else \
;        /let _m1=Idziesz %; \
;        /let _m2=na %; \
;    /endif %; \
;    /let _m3=%{1}%; \
;    /echo -p @{BCwhite}%{_m1} @{nBCcyan}%{_m2} @{nBCgreen}%{_m3}@{nBCwhite}.%; \
;    /test send(strcat(_c1, ' ', _c2, ' ', _m3))

/def _check_go = \
    /if ({2} != 0) \
        /let _m1=Przemykasz sie %; \
        /let _c1=przemknij %; \
        /if ({3} != 0) \
            /let _m2=z druzyna na %; \
            /let _c2=z druzyna %; \
        /else \
            /let _m2=na %; \
        /endif %; \
    /else \
        /let _m1=Idziesz %; \
        /let _m2=na %; \
    /endif %; \
    /let _m3=%{1}%; \
    /echo -p @{BCwhite}%{_m1} @{nBCcyan}%{_m2} @{nBCgreen}%{_m3}@{nBCwhite}.%; \
    /if (_c1 !~ NULL) \
        /if (_c2 !~ NULL) \
            /send -h $[strcat(_c1, ' ', _c2, ' ', _m3)] %; \
        /else \
            /send -h $[strcat(_c1, ' ', _m3)] %; \
        /endif %; \
    /else \
        /send -h %{_m3} %; \
    /endif

; Bindy na zwykle chodzenie
; nkp5 zawsze bedzie na patrzenie :)
/def key_nkp5 = zerknij

/def key_nkp1 = /test _check_go("sw", 0, 0)
/def key_nkp2 = /test _check_go("s",  0, 0)
/def key_nkp3 = /test _check_go("se", 0, 0)
/def key_nkp4 = /test _check_go("w",  0, 0)

/def key_nkp6 = /test _check_go("e",  0, 0)
/def key_nkp7 = /test _check_go("nw", 0, 0)
/def key_nkp8 = /test _check_go("n",  0, 0)
/def key_nkp9 = /test _check_go("ne", 0, 0)

/def key_pgup = /test _check_go("u",  0, 0)
/def key_pgdn = /test _check_go("d",  0, 0)

/set _nietypowe=0

; nietypowe chodzenie
/def _binduj_nietypowe = \
    /def -b'^[Ow' _nietypowe_nw = /test _check_go("nw", 0, 0) %; \
    /def -b'^[Ot' _nietypowe_w = /test _check_go("w", 0, 0) %; \
    /def -b'^[Oq' _nietypowe_sw = /test _check_go("sw", 0, 0) %; \
    /def -b'^[Or' _nietypowe_s = /test _check_go("s", 0, 0) %; \
    /def -b'^[Os' _nietypowe_se = /test _check_go("se", 0, 0) %; \
    /def -b'^[Ov' _nietypowe_e = /test _check_go("e", 0, 0) %; \
    /def -b'^[Oy' _nietypowe_ne = /test _check_go("ne", 0, 0) %; \
    /def -b'^[Ox' _nietypowe_n = /test _check_go("n", 0, 0) %; \
    /def -b'^[Ou' _nietypowe_sp = zerknij 

/def _odbinduj_nietypowe = \
    /purge _nietypowe_*

/def toggle_nietypowe = \
    /if (_nietypowe == 0) \
        /set _nietypowe=1 %; \
        /_binduj_nietypowe %; \
        /pecho Nietypowe bindy na chodzenie wlaczone! %; \
    /else \
        /set _nietypowe=0 %; \
        /_odbinduj_nietypowe %; \
        /pecho Nietypowe bindy na chodzenie WYLACZONE ! %; \
    /endif
        

; Bindy na przemykanie sie

/def key_esc_nkp1 = /test _check_go("sw", 1, 0)
/def key_esc_nkp2 = /test _check_go("s",  1, 0)
/def key_esc_nkp3 = /test _check_go("se", 1, 0)
/def key_esc_nkp4 = /test _check_go("w",  1, 0)

/def key_esc_nkp6 = /test _check_go("e",  1, 0)
/def key_esc_nkp7 = /test _check_go("nw", 1, 0)
/def key_esc_nkp8 = /test _check_go("n",  1, 0)
/def key_esc_nkp9 = /test _check_go("ne", 1, 0)

/def key_esc_pgup = /test _check_go("u",  1, 0)
/def key_esc_pgdn = /test _check_go("d",  1, 0)

; Bindy na przemykanie druzynowe (shift+alt+kierunek)

/def -ib'^[1'  _bind_przem_dr1 = /test _check_go("sw", 1, 1)
/def -ib'^[2'  _bind_przem_dr2 = /test _check_go("s",  1, 1)
/def -ib'^[3'  _bind_przem_dr3 = /test _check_go("se", 1, 1)
/def -ib'^[4'  _bind_przem_dr4 = /test _check_go("w",  1, 1)

/def -ib'^[6'  _bind_przem_dr6 = /test _check_go("e",  1, 1)
/def -ib'^[7'  _bind_przem_dr7 = /test _check_go("nw", 1, 1)
/def -ib'^[8'  _bind_przem_dr8 = /test _check_go("n",  1, 1)
/def -ib'^[9'  _bind_przem_dr9 = /test _check_go("ne", 1, 1)

/def -ib'^[^[[5$'   _bind_przem_dru = /test _check_go("u",  1, 1)
/def -ib'^[^[[6$'   _bind_przem_drd = /test _check_go("d",  1, 1)

;;;; Rozne takie i owakie

/def -ib'^[[5^'     _bind_ctrl_pgup = /dokey_pgup
/def -ib'^[[6^'     _bind_ctrl_pgdn = /dokey_pgdn

/def -ib'^P'        _bind_line_up   = /dokey_lineback
/def -ib'^N'        _bind_line_down = /dokey_line

/def -ib'^[[8~'     _bind_key_end   = /dokey_end

/def key_up     = /dokey_searchb
/def key_down   = /dokey_searchf

/def key_tab    = /complete
/def key_esc_tab= /dokey page

/def key_nkp0	= stan
/def key_nkp.	= kondycja wszystkich

/def key_nkp+   = wyjscie

;;;; Konfiguracja efow (zamiast '/def key_f1 = komenda' to bedzie poprostu '/f1 komenda')

; /test _divide_line("string", na_ile, "znak", 0/1/2/3)
; divide line wyrowna do srodka pomiedzy 'znakiem'
; jesli nie chcemy na koncu znaku, dajemy 1 jako czwarty argument
; jesli nie chcemy na poczatku, dajemy 2
; a jesli nie chcemy ani na poczatku, ani na koncu, dajemy 3
/def _divide_line = \
    /let dl_s=$[strlen({1})] %; \
    /let p_dl=$[expr(dl_s / 2)] %; \
    /let na_i=$[expr({2} / 2)]%; \
    /if ({4} == 1) \
        /return echo(strcat({3}, pad({1}, expr(p_dl + na_i)),   \
            strrep(" ", expr({2} - expr(p_dl + na_i)))), "n", 1) %; \
    /elseif ({4} == 2) \
        /return echo(strcat(pad({1}, expr(p_dl + na_i)),        \
            strrep(" ", expr({2} - expr(p_dl + na_i))), {3}), "n", 1) %; \
    /elseif ({4} == 3) \
        /return echo(strcat(pad({1}, expr(p_dl + na_i)),        \
            strrep(" ", expr({2} - expr(p_dl + na_i)))), "n", 1) %; \
    /else \
        /return echo(strcat({3}, pad({1}, expr(p_dl + na_i)),   \
            strrep(" ", expr({2} - expr(p_dl + na_i))), {3}), "n", 1) %; \
    /endif

;$[pad({1}, expr(expr(strlen({1}) / 2) + expr({2} / 2))]$[strrep(" ", expr({2} - expr(expr(strlen({1}) / 2) + expr({2} / 2))]

; 6, 10, 16, 20, 22
/def _tabela_efow = \
    /let _ilosc_efow=1%; \
    /echo -p @{Cgreen}+$[strrep("-", 78)]+ %; \
    /eval /echo -p @{Cgreen}$(/test _divide_line("Nr", 6, "|", 1\))$(/test _divide_line("Fx", 10, "|", 1\))$(/test _divide_line("Alt + Fx", 16, "|", 1\))$(/test _divide_line("Shift + Fx", 20, "|"\))$(/test _divide_line("Shift + Alt + Fx", 22, "|", 2\)) %; \
    /echo -p @{Cgreen}+$[strrep("-", 78)]+ %; \
    /while (_ilosc_efow < 13) \
        /if ($(/listvar _bind_F%{_ilosc_efow}) !/ "") \
            /let info_1=$(/test _divide_line("Zajety", 10, "|", 2\)) %; \
        /else \
            /let info_1=$(/test _divide_line("", 10, "|", 2\)) %; \
        /endif %; \
        /if ({_ilosc_efow} < 6 | {_ilosc_efow} > 11) \
            /let info_2=$(/test _divide_line("---", 16, "|", 2\)) %; \
        /else \
            /if ($(/listvar _bind_AF%{_ilosc_efow}) !/ "") \
                /let info_2=$(/test _divide_line("Zajety", 16, "|", 2\)) %; \
            /else \
                /let info_2=$(/test _divide_line("", 16, "|", 2\)) %; \
            /endif %; \
        /endif %; \
        /if ({_ilosc_efow} < 3) \
            /let info_3=$(/test _divide_line("---", 20, "|", 2\)) %; \
        /else \
            /if ($(/listvar _bind_SF%{_ilosc_efow}) !/ "") \
                /let info_3=$(/test _divide_line("Zajety", 20, "|", 2\)) %; \
            /else \
                /let info_3=$(/test _divide_line("", 20, "|", 2\)) %; \
            /endif %; \
        /endif %; \
        /if ({_ilosc_efow} < 2 | {_ilosc_efow} > 10) \
            /let info_4=$(/test _divide_line("---", 22, "|", 2\)) %; \
        /else \
            /if ($(/listvar _bind_SAF%{_ilosc_efow}) !/ "") \
                /let info_4=$(/test _divide_line("Zajety", 22, "|", 2\)) %; \
            /else \
                /let info_4=$(/test _divide_line("", 22, "|", 2\)) %; \
            /endif %; \
        /endif %; \
        /let info_0=$(/test _divide_line(strcat("F", {_ilosc_efow}\), 6, "|"\))%; \
        /test echo(strcat({info_0}, {info_1}, {info_2}, {info_3}, {info_4}), "Cgreen", 1)%; \
        /test ++_ilosc_efow%; \
    /done %; \
    /echo -p @{Cgreen}+$[strrep("-", 78)]+


;; A na cholere mi to?
; /_tabela_efow

;;; Do pliku sa zapisywane wszystkie dane efow, czyli przed odpaleniem skryptu
;;; Mozna recznie zmienic kazda wartosc jakiegos efa ;-)
;;; Przy kazdym zmianie bindu na efy, bedzie do pliku zapisywana
;;; Lista z aktualnymi zapamietanymi bindami

/eval /set _bind_file=%{DBDIR}/bindy.db

;;; doeach to funkcja YaaL, bardzo przydatna ;-) (funkcja)
/def -i doeach = \
    /let _cmd=%{1}%; \
    /while (shift(), {#}) \
        /eval %{_cmd} %%{1}%; \
    /done

;; tutaj nie wiem dlaczego mam blad przy odpalaniu skryptow... :/
/rstop save_current_binds
/repeat -600 i /save_current_binds

; funkcja save_current_binds sluzy do zapisania do pliku wszystkich aktualnych
; bindow (jaka paskudna :/)
/def save_current_binds = \
    /if (!getopts("s", "")) /return 0%; /endif %; \
    /if ((uchwyt := tfopen(_bind_file, "w")) < 0) \
        /return 0%; \
        /echo Blad zapisu listy bindow do pliku %{_bind_file}!%; \
    /endif %; \
    /test tfflush(uchwyt, 0) %; \
    /let _ilosc_efow=1 %; \
    /while (_ilosc_efow < 13) \
        /if ($(/listvar -v _bind_F%{_ilosc_efow}) !/ "") \
            /save_one_bind _bind_F%{_ilosc_efow}  %; \
        /endif %; \
        /test ++_ilosc_efow %; \
    /done %; \
    /let _ilosc_efow=1 %; \
    /while (_ilosc_efow < 13) \
        /if ($(/listvar -v _bind_AF%{_ilosc_efow}) !/ "") \
            /save_one_bind _bind_AF%{_ilosc_efow}  %; \
        /endif %; \
        /test ++_ilosc_efow %; \
    /done %; \
    /let _ilosc_efow=1 %; \
    /while (_ilosc_efow < 13) \
        /if ($(/listvar -v _bind_SF%{_ilosc_efow}) !/ "") \
            /save_one_bind _bind_SF%{_ilosc_efow}  %; \
        /endif %; \
        /test ++_ilosc_efow %; \
    /done %; \
    /let _ilosc_efow=1 %; \
    /while (_ilosc_efow < 13) \
        /if ($(/listvar -v _bind_SAF%{_ilosc_efow}) !/ "") \
            /save_one_bind _bind_SAF%{_ilosc_efow}  %; \
        /endif %; \
        /test ++_ilosc_efow %; \
    /done %; \
    /test tfclose(uchwyt)%; \
    /if (opt_s) \
        /echo Bindy zostaly poprawnie zapisane do pliku %{_bind_file}!%; \
    /endif

/def save_one_bind = \
    /test tfwrite(uchwyt, strcat(substr({1}, 6), ":", %{1}))

;; Funkcja load_all_binds laduje do pamieci wszystkie bindy z pliku %_bind_file
;; Oczywiscie chodzi o bindy efow :]

/def load_all_binds = \
    /if ((uchwyt := tfopen(_bind_file, "r")) < 0) \
        /return 0 %; \
        /echo Nie moge otworzyc pliku %{_bind_file}!%; \
    /endif %; \
    /let temp_sub=$(/listvar -v sub)%; \
    /set sub off %; \
    /while (tfread(uchwyt, numer) >= 0) \
        /let _f=$[substr(numer, 0, strchr(numer, ":"))]%; \
        /let _w=$[substr(numer, strchr(numer, ":") + 1)]%; \
;        /mesg -i %_f = %_w%; \
        /set _bind_%{_f}=%{_w}%; \
    /done %; \
    /test tfclose(uchwyt)%; \
    /set sub=%{temp_sub} %; \
    /mesg -i Efy zostaly pomyslnie zaladowane do pamieci.

/load_all_binds


/def skonfiguruj_efy = \
    /_skonfiguruj_f %; \
    /_skonfiguruj_alt_f %; \
    /_skonfiguruj_shift_f %; \
    /_skonfiguruj_shift_alt_f %; \
    /mesg -i Wszystkie efy zostaly skonfigurowane.

; Od f1 - f12
/def _skonfiguruj_f = \
    /let _ilosc_efow=12%; \
    /while (_ilosc_efow > 0) \
        /def -i f%{_ilosc_efow} = \
            /if (!getopts("dq", "")) /return 0 %%; /endif %%; \
            /if (opt_d) \
                /if (!opt_q) \
                    /eval /mesg -i Bind F%{_ilosc_efow} zostal usuniety! Oznaczal %%{_bind_F%{_ilosc_efow}}%%; \
                /endif %%; \
                /unset _bind_F%{_ilosc_efow} %%; \
                /return %%; \
            /endif %%; \
            /if ({*} !~ NULL) \
                /set _bind_F%{_ilosc_efow}=%%{*} %%; \
                /if (!opt_q) \
                    /mesg -i Od teraz F%{_ilosc_efow} oznacza %%{*}%%;\
                /endif %%; \
            /else \
                /if ($$(/listvar _bind_F%{_ilosc_efow}) !/ "") \
                    /if (!opt_q) \
                        /mesg -i F%{_ilosc_efow} oznacza %%{_bind_F%{_ilosc_efow}}%%; \
                    /endif %%; \
                /else \
                    /if (!opt_q) \
                        /mesg -i Bind %{_ilosc_efow} nie jest ustawiony!%%; \
                    /endif %%; \
                /endif %%;\
            /endif %; \
;            /save_current_binds %; \
        /def key_f%{_ilosc_efow} = \
            /eval %%{_bind_F%{_ilosc_efow}}%; \
        /test --_ilosc_efow %; \
    /done %; \
    /mesg -i Skonczylem konfigurowac Fx!

; Od f6 - f11 (alt + fx)
/def _skonfiguruj_alt_f = \
    /let _ilosc_efow=11%; \
    /while (_ilosc_efow > 5) \
        /def -i af%{_ilosc_efow} = \
            /if (!getopts("dq", "")) /return 0 %%; /endif %%; \
            /if (opt_d) \
                /if (!opt_q) \
                    /eval /mesg -i Bind Alt + F%{_ilosc_efow} zostal usuniety! Oznaczal %%{_bind_AF%{_ilosc_efow}}%%; \
                /endif %%; \
                /unset _bind_AF%{_ilosc_efow} %%; \
                /return %%; \
            /endif %%; \
            /if ({*} !~ NULL) \
                /set _bind_AF%{_ilosc_efow}=%%{*} %%; \
                /if (!opt_q) \
                    /mesg -i Od teraz Alt + F%{_ilosc_efow} oznacza %%{*}%%;\
                /endif %%; \
            /else \
                /if ($$(/listvar _bind_AF%{_ilosc_efow}) !/ "") \
                    /if (!opt_q) \
                        /mesg -i Alt + F%{_ilosc_efow} oznacza %%{_bind_AF%{_ilosc_efow}}%%; \
                    /endif %%; \
                /else \
                    /if (!opt_q) \
                        /mesg -i Bind %{_ilosc_efow} nie jest ustawiony!%%; \
                    /endif %%; \
                /endif %%;\
            /endif %; \
;            /save_current_binds %; \
        /def key_esc_f%{_ilosc_efow} = \
            /eval %%{_bind_AF%{_ilosc_efow}}%; \
        /test --_ilosc_efow %; \
    /done %; \
    /mesg -i Skonczylem konfigurowac Alt + Fx!


; Dodac to co wyzej
; Od f3 do f12, z czego f11 i f12 maja niestandardowy kod (shift + fx)
/def _skonfiguruj_shift_f = \
    /let _ilosc_efow=10 %; \
    /while (_ilosc_efow > 2) \
        /def -i sf%{_ilosc_efow} = \
            /set _bind_SF%{_ilosc_efow}=%%{*} %%; \
            /mesg -i Od teraz Shift + F%{_ilosc_efow} oznacza %%{*}%; \
        /def key_f$[expr(_ilosc_efow + 10)] = \
            /eval %%{_bind_SF%{_ilosc_efow}}%; \
        /test --_ilosc_efow %; \
    /done %; \
    /let temp_sub=$(/listvar -v sub)%; \
    /set sub off %; \
    /def -i sf11    =   /set _bind_SF11=%%{*} %%; /mesg -i Od teraz Shift + F11 oznacza %%{*}%; \
    /def -i sf12    =   /set _bind_SF12=%%{*} %%; /mesg -i Od teraz Shift + F12 oznacza %%{*}%; \
    /def -ib"^[[23\\\$"    _bind_shift_f11 = /eval %%{_bind_SF11} %; \
    /def -ib"^[[24\\\$"    _bind_shift_f12 = /eval %%{_bind_SF12} %; \
    /set sub=%{temp_sub} %; \
    /mesg -i Skonczylem konfigurowac Shift + Fx!

; Jw.
; Od f2 do f10 (shift + alt + fx)
/def _skonfiguruj_shift_alt_f = \
    /let _ilosc_efow=10 %; \
    /while (_ilosc_efow > 1) \
        /def -i saf%{_ilosc_efow} = \
            /set _bind_SAF%{_ilosc_efow}=%%{*} %%; \
            /mesg -i Od teraz Shift + Alt + F%{_ilosc_efow} oznacza %%{*}%; \
        /def key_esc_f$[expr(_ilosc_efow + 10)] = \
            /eval %%{_bind_SAF%{_ilosc_efow}}%; \
        /test --_ilosc_efow %; \
    /done %; \
    /mesg -i Skonczylem konfigurowac Shift + Alt + Fx!


; Konfigurujemy
/skonfiguruj_efy

/def te = /_tabela_efow


/set _alfabet=a b c d e f g h i j k l m n o p q r s t u v w x y z

/def skonfiguruj_litery = \
    /let _przedrostek_ctrl=^%; \
    /let _przedrostek_alt=^[%; \
    /while ({#}) \
        /def bind_ctrl_%{1} = \
            /set _var_bind_ctrl_%{1}=%%{*} %%; \
            /def -b'%{_przedrostek_ctrl}%{1}' _def_bind_ctrl_%{1} = \
                /eval %%{_var_bind_ctrl_%{1}}%;\
        /def bind_alt_%{1}  = \
            /set _var_bind_alt_%{1}=%%{*} %%; \
            /def -b'%{_przedrostek_alt}%{1}'  _def_bind_alt_%{1} = \
                /eval %%{_var_bind_alt_%{1}}%;\
        /def bind_shift_alt_%{1} = \
            /set _var_bind_shift_alt_%{1}=%%{*} %%; \
            /def -b'%{_przedrostek_alt}$[toupper({1})]' _def_bind_shift_alt_%{1} = \
                /eval %%{_var_bind_shift_alt_%{1}} %;\
        /shift %;\
    /done %; \
    /mesg -i Litery zostaly skonfigurowane.

/eval /skonfiguruj_litery %{_alfabet}

