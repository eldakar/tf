/def skory = \
;    /sprzedaj_skory
    otworz plecak %; wez skory z plecaka %; \
    /repeat -0 20 sprzedaj skore %; \
    /repeat -1 1 wloz monety do plecaka %%; zamknij plecak

/def res_skor = /purge _skory_* %; \
    /set _sk_zl=0 %; \
    /set _sk_sr=0

;Sprzedajesz brunatna cienka skore, w zamian dostajac 1 zlota i 5 srebrnych monet.
;Sprzedajesz gruba ciezka skore,    w zamian dostajac 7 zlotych monet.

/set _sk_zl=0
/set _sk_sr=0

/def sprzedaj_skory = \
    otworz plecak %; \
    wez skory z plecaka %; \
    /def -F -aB -mregexp -t'^Wez co?'  _skory_1 = \
        /pecho Nie masz skor, wiec nie sprzedajemy. %%; \
        /res_skor %;\
    /def -F -aB -mregexp -t'^Bierzesz .*' _skory_2 = \
        sprzedaj skore %%; \
        /def -F -aB -mregexp -t'^Sprzedaj co?'  _skory_3 = \
            /pecho Nie mam skor, przerywam skrypt %%%; \
            /kasa_ze_skor %%%; \
            /res_skor %%; \
        /def -F -aB -mregexp -t'^Sprzedajesz.* w zamian dostajac (\\\\d) zlot(e|a|ych) (i (\\\\d) srebrn(a|e|ych) |)mone(t|te|ty)' _skory_4 = \
            /set _sk_zl=$$$[_sk_zl + {P1}] %%%; \
            /set _sk_sr=$$$[_sk_sr + {P4}] %%%; \
            sprzedaj skore

/def kasa_ze_skor = \
    /mesg -i Za skory dostajesz %{_sk_zl} zlota i %{_sk_sr} srebra.

;/def -F -ab -mregexp -t'^Sprzedajesz.* w zamian dostajac (\d) zlot(e|a|ych) (i (\d) srebrn(a|e|ych) |)mone(t|te|ty)' _skor_test = \
;    /sprawdz_def