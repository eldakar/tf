;
; Plik  : defs.tf
; Autor : volus
; Data  : 05/03/2006, 23:31:31
; Opis  : Takie tam defy ;)
;

;;; Zmienne
/set _important=>>> * ---=======> * <=======--- * <<<

;;;; Kolorki
/def -F -P0BCgreen -t' ci(e(bie|)|)[,. ]'	_kolor_ciebie

;;;; Defzy
/def ja = sp na siebie
/def p  = przejrzyj %*
/def cz = przeczytaj %*

;;;; Przeladowanie wszystkich makr...
/def reload = \
    /cd %{TFDIR} %; \
    /purge %; \
    /purge -i ~alias* %; \
    /load login.tf %; \
    /repeat -0.5 1 /load start.tf %; \
    /repeat -1   1 /pecho Skrypty zostaly przeladowane.    

;;; zapisywanie aliasa
/eval /set alias_db=%{DBDIR}/aliasy.tf

/def zapisz_alias = \
    /if ({1} =~ NULL) \
        /pecho Uzycie: /zapisz_alias nazwa_aliasa%;\
        /return %;\
    /endif %; \
    /if ($(/list -i ~alias_body_%{1}) =/ "") \
        /mesg -w Taki alias %{1} nie istnieje!%;\
        /return %;\
    /endif %; \
    /quote -S /~listalias `/@list -s -I -mglob ~alias_body_%{1}%|/writefile -a %{alias_db}%;\
    /pecho Zapisalem alias '%{1}' do pliku %{alias_db}

/def za = /zapisz_alias %{*}

;;;
/def -Fp{maxpri} -mregexp -t'^(> )'	_sub_usun_znaczniki = \
    /substitute -p %{PR}

/def mesg = \
    /if (!getopts("iw", "")) /return 0%; /endif %; \
    /if ({opt_i}) \
        /test echo(strcat("@{BCgreen}####@{n}", " @{Cyellow}", {*}), "", 1) %; \
    /elseif ({opt_w}) \
        /test echo(strcat("@{BCgreen}####@{n}", " @{BCred}", {*}), "", 1) %; \
    /else \
        /test echo(strcat("@{BCgreen}####@{n}", " ", {*}), "", 1) %; \
    /endif

/def xecho = \
    /echo -p %{*}

/def pecho = \
    /echo -p @{Cgreen}(+) @{n}%{*}

;; By Ingwar
/purge -i pid_of
/def -i pid_of = \
    /quote -S \
        /eval /let pid_czego=`"/@ps -r" %%; \
        /if (strstr(pid_czego, {*}) != -1) \
            /first %%{pid_czego} %%; \
        /endif

/def rstart = /if ($(/pid_of %{-2}) =~ NULL) /repeat %{1} %{2} %{-2} %; /endif
/def rstop  = /kill $(/pid_of %{*})


/def clear = \
    /repeat -0 $[winlines()] /echo

/def shh = \
    /echo

/def file_exists = \
  /let _filename=%{*} %; \
  /if (tfopen(_filename, "r") == -1) \
    /result 0 %; \
  /else \
    /result 1 %; \
  /endif

/def kate = \
 /if ({*} =~ NULL) \
  /echo Uzycie: /kate plik%;\
 /else \
  /sys kate -u %*%;\
 /endif


/def ls = \
 /let sciezka_do_ls=%{*}%;\
 /if (sciezka_do_ls =~ NULL) \
  /let sciezka_do_ls=$(/pwd)%;\
 /endif%;\
 /let sciezka_do_ls=%{sciezka_do_ls}/ %;\
 /pecho @{Cgreen}Zawartosc katalogu %sciezka_do_ls -----------------%;\
 /sys ls -C -F %sciezka_do_ls

/def autoreconnect = \
    /if ({*} =~ NULL) \
        /mesg -i Blad skladni.%;\
        /mesg -i Uzycie      : /autoreconnect on|off%; \
        /return %; \
    /endif %; \
    /if ({*} =~ "on") \
        /mesg -i Auto Reconnect wlaczony!%; \
        /repeat -30 i /reconnecting %; \
    /elseif ({*} =~ "off") \
        /mesg -i Auto Reconnect wylaczony!%; \
        /rstop reconnecting %; \
    /else \
        /mesg Blad skladni.%; \
    /endif

/def reconnecting = \
        /if (!is_connected()) \
            /connect %; \
        /else \
            /autoreconnect off %; \
        /endif

;/def -p0 -hDISCONNECT _hook_disconnect = /autoreconnect on

; ---------- lampa ---------
/def zpl = zapal lampe
/def zgl = zgas lampe
/def nap = napelnij lampe olejem z butelki
/def odb = odloz butelke


; ---------- sjorv -----------
;; zmieniam aby korzystalo z /query_pojemnik, sprawdza czy otwarty
;; nie zamyka po operacji
/def wl = \
    /if (!_sprzet_pojemnik_otwarty) \
        otworz $(/m_bie_n $(/query_pojemnik)) %;\
    /endif %; \
    /let _var=$[replace(",", "|", replace(" i ", "|", {*}))]|%; \
    /while /let i=$[strstr(_var, "|")] %; /@test i > -1 %; /do \
        /send wloz $[substr(_var, 0, i)] do $(/m_dop_n $(/query_pojemnik)) %; \
        /let _var=$[substr(_var, i + 1)] %; \
    /done %; \

/def wz = \
    /if (!_sprzet_pojemnik_otwarty) \
        otworz $(/m_bie_n $(/query_pojemnik)) %;\
    /endif %; \
    /let _var=$[replace(",", "|", replace(" i ", "|", {*}))]|%; \
    /while /let i=$[strstr(_var, "|")] %; /@test i > -1 %; /do \
        /send wez $[substr(_var, 0, i)] z $(/m_dop_n $(/query_pojemnik)) %; \
        /let _var=$[substr(_var, i + 1)] %; \
    /done %; \

;; stare komendy wkladania i wyjmowania
/def swl = \
    otworz plecak %;\
    /let _var=$[replace(",", "|", replace(" i ", "|", {*}))]|%; \
    /while /let i=$[strstr(_var, "|")] %; /@test i > -1 %; /do \
        /send wloz $[substr(_var, 0, i)] do plecaka %; \
        /let _var=$[substr(_var, i + 1)] %; \
    /done %; \
    zamknij plecak

/def swz = \
    otworz plecak %;\
    /let _var=$[replace(",", "|", replace(" i ", "|", {*}))]|%; \
    /while /let i=$[strstr(_var, "|")] %; /@test i > -1 %; /do \
        /send wez $[substr(_var, 0, i)] z plecaka %; \
        /let _var=$[substr(_var, i + 1)] %; \
    /done %; \
    zamknij plecak
;;;;;;;;; ---- najogolniejsze rzeczy, podswietlanie itp.

;; Podswietlanie rasy;
/def _dodaj_rase = \
    /eval /def -mregexp -Fp25 -P1BCwhite -t'($(/zwroc_regexp %{1}))[ ,.]'     _hilite_rasy_%{1}

/purge _hilite_rasy_*

/mesg -i Laduje podswietlanie ras...

/_dodaj_rase mezczyzna
/_dodaj_rase mezczyzni
/_dodaj_rase kobieta
/_dodaj_rase kobiety
/_dodaj_rase czlowiek
/_dodaj_rase ludzie

/_dodaj_rase krasnolud
/_dodaj_rase krasnoludy
/_dodaj_rase krasnoludka
/_dodaj_rase krasnoludki

/_dodaj_rase ogr
/_dodaj_rase ogry
/_dodaj_rase ogrzyca
/_dodaj_rase ogrzyce

/_dodaj_rase halfling
/_dodaj_rase halflingi
/_dodaj_rase halflinka
/_dodaj_rase halflinki

/_dodaj_rase gnom
/_dodaj_rase gnomy
/_dodaj_rase gnomka
/_dodaj_rase gnomki

/_dodaj_rase niziolek
/_dodaj_rase niziolki
/_dodaj_rase niziolka
;; tutaj wyjatek, bo niziolki w mianownik w mnogiej jest taki sam dla meskiego i zenskiego rodzaju
;; meski jest w bazie danych, zenski trzeba recznie
/def -mregexp -F -P1BCwhite -t'(niziol(ki|ek|kom|kami|kach))[ ,.]'     _hilite_rasy_niziolki_z

/_dodaj_rase mutant
/_dodaj_rase mutanci
/_dodaj_rase mutantka
/_dodaj_rase mutantki

/_dodaj_rase polelf
/_dodaj_rase polelfy
/_dodaj_rase polelfka
/_dodaj_rase polelfki

/_dodaj_rase elf
/_dodaj_rase elfy
/_dodaj_rase elfka
/_dodaj_rase elfki

/mesg -i ... skonczylem ladowac podswietlanie ras.

;;;; podswietlanie broni
/def _dodaj_bron = \
    /eval /def -mregexp -F -P1BCgreen -t'($(/zwroc_regexp %{1}))[ ,.]'     _hilite_broni_%{1}

/def _dodaj_zbroje = \
    /eval /def -mregexp -F -P1BCyellow -t'($(/zwroc_regexp %{1}))[ ,.]'     _hilite_zbroi_%{1}

/purge _hilite_broni_*
/purge _hilite_zbroi_*

/mesg -i Laduje podswietlanie broni ...


;;;; miecze

/_dodaj_bron miecz
/_dodaj_bron miecze

/_dodaj_bron szabla
/_dodaj_bron szable

/_dodaj_bron scimitar
/_dodaj_bron scimitary

/_dodaj_bron espadon
/_dodaj_bron espadony

/_dodaj_bron rapier
/_dodaj_bron rapiery

/_dodaj_bron schiavona
/_dodaj_bron schiavony

/_dodaj_bron szpada
/_dodaj_bron szpady

/_dodaj_bron poltorak
/_dodaj_bron poltoraki

/_dodaj_bron flamberg
/_dodaj_bron flambergi

/_dodaj_bron claymore
/_dodaj_bron claymory

/_dodaj_bron tasak
/_dodaj_bron tasaki

/_dodaj_bron nimsza
/_dodaj_bron nimsze

/_dodaj_bron szamszir
/_dodaj_bron szamsziry

/_dodaj_bron saif
/_dodaj_bron saify

/_dodaj_bron katzbalger
/_dodaj_bron katzbalgery

/_dodaj_bron falchion
/_dodaj_bron falchiony

;;;; sztylety

/_dodaj_bron sztylet
/_dodaj_bron sztylety

/_dodaj_bron noz
/_dodaj_bron noze

/_dodaj_bron nozyk
/_dodaj_bron nozyki

/_dodaj_bron stiletto
/_dodaj_bron stiletta

/_dodaj_bron mizerykordia
/_dodaj_bron mizerykordie

/_dodaj_bron baselard
/_dodaj_bron baselardy

/_dodaj_bron kordelas
/_dodaj_bron kordelasy

/_dodaj_bron cinquenda
/_dodaj_bron cinquendy

/_dodaj_bron puginal
/_dodaj_bron puginaly

/_dodaj_bron katar
/_dodaj_bron katary

;;;; macki

/_dodaj_bron maczuga
/_dodaj_bron maczugi

/_dodaj_bron palka
/_dodaj_bron palki

/_dodaj_bron wekiera
/_dodaj_bron wekiery

/_dodaj_bron morgenstern
/_dodaj_bron morgensterny

/_dodaj_bron buzdygan
/_dodaj_bron buzdygany

/_dodaj_bron bulawa
/_dodaj_bron bulawy

/_dodaj_bron kiscien
/_dodaj_bron kiscieny

/_dodaj_bron korbacz
/_dodaj_bron korbacze

/_dodaj_bron chochla
/_dodaj_bron chochle

;;;; mloty

/_dodaj_bron mlot
/_dodaj_bron mloty

/_dodaj_bron mlotek
/_dodaj_bron mlotki

/_dodaj_bron nadziak
/_dodaj_bron nadziaki

;;;; toporki

/_dodaj_bron topor
/_dodaj_bron topory

/_dodaj_bron toporek
/_dodaj_bron toporki

/_dodaj_bron czekan
/_dodaj_bron czekany

/_dodaj_bron berdysz
/_dodaj_bron berdysze

;;;; drzewcowki

/_dodaj_bron wlocznia
/_dodaj_bron wlocznie

/_dodaj_bron partyzana
/_dodaj_bron partyzany

/_dodaj_bron rohatyna
/_dodaj_bron rohatyny

/_dodaj_bron oszczep
/_dodaj_bron oszczepy

/_dodaj_bron pika
/_dodaj_bron piki

/_dodaj_bron kosa
/_dodaj_bron kosy

/_dodaj_bron halabarda
/_dodaj_bron halabardy

/_dodaj_bron cep
/_dodaj_bron cepy

/_dodaj_bron gizarma
/_dodaj_bron gizarmy

/_dodaj_bron widly

/_dodaj_bron sierp
/_dodaj_bron sierpy

/_dodaj_bron motyka
/_dodaj_bron motyki

/_dodaj_bron laska
/_dodaj_bron laski

/_dodaj_bron dzida
/_dodaj_bron dzidy

/_dodaj_bron kij
/_dodaj_bron kije

;;; koniec
/mesg -i ... zaladowalem bronie.

;;; no to jedziemy zbroje
/mesg -i ... laduje zbroje ...

;;; na glowe

/_dodaj_zbroje helm
/_dodaj_zbroje helmy

/_dodaj_zbroje misiurka
/_dodaj_zbroje misiurki

/_dodaj_zbroje szyszak
/_dodaj_zbroje szyszaki

/_dodaj_zbroje kapalin
/_dodaj_zbroje kapaliny

/_dodaj_zbroje diadem
/_dodaj_zbroje diademy

/_dodaj_zbroje salada
/_dodaj_zbroje salady

/_dodaj_zbroje napiersnik
/_dodaj_zbroje napiersniki

/_dodaj_zbroje kirys
/_dodaj_zbroje kirysy

/_dodaj_zbroje kolczuga
/_dodaj_zbroje kolczugi

/_dodaj_zbroje kaftan
/_dodaj_zbroje kaftany

/_dodaj_zbroje pancerz
/_dodaj_zbroje pancerze

/_dodaj_zbroje kurtka
/_dodaj_zbroje kurtki

/_dodaj_zbroje tarcza
/_dodaj_zbroje tarcze

/_dodaj_zbroje puklerz
/_dodaj_zbroje puklerze

/_dodaj_zbroje naramiennik
/_dodaj_zbroje naramienniki

/_dodaj_zbroje nagolenniki

/_dodaj_zbroje koszula
/_dodaj_zbroje koszule

/_dodaj_zbroje plaszcz
/_dodaj_zbroje plaszcze

/_dodaj_zbroje czapka
/_dodaj_zbroje czapki

/_dodaj_zbroje tunika
/_dodaj_zbroje tuniki

/_dodaj_zbroje karwasz
/_dodaj_zbroje karwasze

/_dodaj_zbroje rekawica
/_dodaj_zbroje rekawice

/_dodaj_zbroje brygantyna
/_dodaj_zbroje brygantyna

/_dodaj_zbroje przeszywanica
/_dodaj_zbroje przeszywanice

;;; na nogi

/_dodaj_zbroje buty
/_dodaj_zbroje sandaly

/_dodaj_zbroje kamizelka

/mesg -i ... zbroje zaladowane.


;;; przerozne zaznaczenia
/def -F -P0Cgreen;RBCgreen -mregexp -t'^Znajdujesz (?!sie)'  _zaznaczenie_znalezlismy_ziolo = 
;    otworz sloik %; wloz ziola do sloika %; zamknij sloik

;;; def do odpalania programow w tle.
/def odpalaj = \
    /quote -S -decho !%{*} > /dev/null 2> /dev/null < /dev/null & true

;;; :P /in 10 zakoncz, po 10 sekundach zakonczy :)
/def in = \
    /repeat -%{1} 1 %{-1}
