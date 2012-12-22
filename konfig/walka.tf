;
; Plik  : walka.tf
; Autor : volus
; Data  : 11/03/2006, 18:14:07
; Opis  : Rzeczy zwiazane z walka
;

/set _znacznik_walki_ja=@{BCmagenta}[ > ]@{n}
/set _znacznik_walki_ja_spec=@{BCmagenta}[SPEC]@{n}

/set _znacznik_walki_we_mnie=@{BCred}[<<<]@{n}
/set _znacznik_walki_we_mnie_parada=@{BCred}[parada]@{n}
/set _znacznik_walki_we_mnie_oslona=@{BCred}[oslona]@{n}
/set _znacznik_walki_we_mnie_unik=@{BCred}[ unik ]@{n}
/set _znacznik_walki_nie_trafia_albo_zbroja_paruje=@{BCred}[ fail ]@{n}

/set _znacznik_walki_inni=@{BCcyan}[ * ]@{n}
/set _znacznik_walki_rozne=@{BCyellow}[ + ]@{n}

/def -P0BCcyan -mregexp -t'^(Ledwo muskasz|Lekko ranisz|Ranisz|Powaznie ranisz|Bardzo ciezko ranisz|Masakrujesz) '                                  _walka_uderzam = \
    /if ({P1} =~ "Ledwo muskasz") \
        /test ++_stat_cios_ledmus %; \
    /elseif ({P1} =~ "Lekko ranisz") \
        /test ++_stat_cios_lekran %; \
    /elseif ({P1} =~ "Ranisz") \
        /test ++_stat_cios_ranisz %; \
    /elseif ({P1} =~ "Powaznie ranisz") \
        /test ++_stat_cios_powran %; \
    /elseif ({P1} =~ "Bardzo ciezko ranisz") \
        /test ++_stat_cios_bacira %; \
    /elseif ({P1} =~ "Masakrujesz") \
        /test ++_stat_cios_masakr %; \
    /else \
        /test ++_stat_cios_niezid %; \
    /endif %; \
    /substitute -p %{_znacznik_walki_ja} %{PL}%{P0}%{PR}

/def -PLBCwhite;1Ccyan -mregexp  -t' (ledwo muska|lekko rani|(?<!powaznie |bardzo ciezko )rani|powaznie rani|bardzo ciezko rani|masakruje) (?!cie )'  _walka_uderza_ktos = \
    /substitute -p %{_znacznik_walki_inni} %{PL}%{P0}%{PR}
/def -PLBCwhite;1BCcyan -mregexp -t' (ledwo muska|lekko rani|(?<!powaznie |bardzo ciezko )rani|powaznie rani|bardzo ciezko rani|masakruje) cie '     _walka_uderza_mnie = \
    /substitute -p %{_znacznik_walki_we_mnie} %{PL}$[toupper({P0})]%{PR}

;; przeciwnik paruje bronia
/def -F -P5BCwhite -mregexp -t'^(Wyprowadzasz|Wykonujesz) (szybkie pchniecie|zamach|zamaszyste ciecie) .* (mierzac |)w (.*), lecz [^ ]* (zbija je z linii ataku|paruje go)' _walka_parada_nie_trafiam = \
    /substitute -p %{_znacznik_walki_rozne} %{PL}%{P0}%{PR}
    
;; ja paruje bronia
/def -F -mregexp -t'(wyprowadza|wykonuje) (szybkie pchniecie|zamach|zamaszyste ciecie) .* (mierzac |)w ciebie, lecz tobie udaje sie (zbic je z linii ataku|go sparowac)' _walka_parada_ktos_nie_trafia_we_mnie = \
    /substitute -p %{_znacznik_walki_we_mnie_parada} %{PL}%{P0}%{PR}

;; ja unikam ciosu
/def -F -PLBCwhite -mregexp -t'probuje cie trafic .*, lecz tobie udaje sie uniknac tego ciosu' _walka_uniknalem_ciosu = \
    /substitute -p %{_znacznik_walki_we_mnie_unik} %{PL}%{P0}%{PR}

;; ja oslaniam sie tarcza
/def -F -PLBCwhite -mregexp -t'(wyprowadza|wykonuje) (szybkie pchniecie|zamach|zamaszyste ciecie) .* (mierzac |)w ciebie, lecz (tobie udaje sie oslonic|udaje ci sie oslonic)' _walka_oslona_ktos_trafia_w_moja_tarcze = \
    /substitute -p %{_znacznik_walki_we_mnie_oslona} %{PL}%{P0}%{PR}

;; nie trafiaja mnie albo zbroja paruje cios
/def -F -PLBCwhite -mregexp -t'(nie udaje sie trafic ciebie|trafia cie .* w .*, lecz caly impet uderzenia zostaje wyparowany przez)' _walka_nie_trafiaja_mnie_lub_zbroja_paruje = \
    /substitute -p %{_znacznik_walki_nie_trafia_albo_zbroja_paruje} %{PL}%{P0}%{PR}

;; Dzieki sarakin za podpowiedz z regexpem ;)
/def -F -P1BCwhite -mregexp -t'^Probujesz trafic((?: (?:[a-z]+)){3})((?: (?:[a-z]+)){3,}), lecz [^ ]* uskakuje przed twoim ciosem\.'  _walka_nie_trafiam_2 = \
    /substitute -p %{_znacznik_walki_rozne} %{PL}%{P0}%{PR}

/def -F -P1BCwhite -mregexp -t'^Nie udaje ci sie trafic((?: (?:[a-z]+)){3})((?: (?:[a-z]+)){3,})\.' _walka_nie_trafiam_3 = \
    /substitute -p %{_znacznik_walki_rozne} %{PL}%{P0}%{PR}

/def -F -P1BCwhite -mregexp -t'Trafiasz ((?:(?:[a-z]+)){3})((?: (?:[a-z]+)){3,}), lecz caly impet uderzenia zostaje wyparowany przez .*\.' _nie_trafiam_4 = \
    /substitute -p %{_znacznik_walki_rozne} %{PL}%{P0}%{PR}


;; spec
/def -F -P1BCwhite;2BCred -mregexp -t'^Wykorzystujac dogodny moment wyprowadzasz celne .+ w (.+), (.+) (go|ja|je) w .+' _spec_trafiony = \
    /substitute -p %{_znacznik_walki_ja_spec}: %{P2}: %{PL}%{P0}%{PR}

;; add_important
;; Zajebiscie mi sie podoba ta funkcja
;; Uzycie przez test
;; /test add_important(str, "info", "kolor_infa", "kolor_important")
;; Istnieje taka zmienna _important, ktora no wiadomo jaka jest
;; A funkcja add_important dodaje wlasnie _important do linii, jaka
;; chcemy naznaczyc ze jest wazna
;; Wszystkie cztery argumenty sa potrzebne.
;; Pierwszy to jest string przerobiony i gotowy na zmiane
;; W funkcji gdzie chcemy zmienic linie mozna dodac np.
;; /let _str=_i tutaj ta linia
;; Drugi argument to napis jaki ma sie pokazac przed zmienna _important
;; Trzeci argument to kolor na jaki ma byc pokolorowany ten napis
;; Czwarty to kolor zmiennej _important
;; Uzycie funkcji dla przykladu:
;; /def -F -mregexp -t'atakuje cie(bie|)!' _atak_ = \
;;     /let _str=@{BCwhite}%{PL}@{BCred}$[toupper({P0})]%;\
;;     /test add_important(_str, "ATAKUJA_CIE", "BCyellow", "BCgreen")
;; Co w wyniku gdy ktos nas zaatakuje otrzymamy zamiast:
;; Maly mutancik atakuje cie!
;; Dostaniemy cos takiego:
;; Maly mutancik ATAKUJE CIE!                     ATAKUJA_CIE >>> * ---=====> * <====--- * <<<
/def add_important = \
    /let _string=%{1}%; \
    /let _string_in=%{2}%; \
    /let _string_c_inf=%{3}%; \
    /let _string_c_imp=%{4}%; \
    /let _int=$[strlen(_string)]%;\
    /let _int_i=$[strlen(_important)]%;\
    /let _int_w=%{wrapsize}%;\
    /let _int_in=$[strlen(_string_in)]%;\
    /substitute -p %{_str}$[strrep(" ", _int_w - _int_i - _int_in - _int - (_int_w / 4))]@{%_string_c_inf}%{_string_in}@{n%_string_c_imp} %{_important}%; \

/def -F -mregexp -t'atakuje cie(bie|)!' _atak_ = \
    /let _str=@{BCwhite}%{PL}@{BCred}$[toupper({P0})]%;\
    /let _str=$[decode_attr(_str)]%;\
    /test add_important(_str, "ATAKUJA_CIE", "BCyellow", "BCgreen")%; \
    /beep 1

/def -F -mregexp -aBCmagenta -t'(umarl|polegl|rozsypuje sie w proch|osuwa sie na ziemie w agonii)'   _kolor_umarl

/def key_nkp- = wesprzyj

;; ---------------------------------
;/def -F -mregexp -t'zrecznie zaslania cie przed ciosami' _zas_1 = \
; /echo -p @{BCmagenta}TERAZ @{nBCgreen}%{PR}@{nBCmagenta} bije @{nBCyellow}%{PL}
