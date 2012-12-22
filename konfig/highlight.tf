;
; Plik  : highlight.tf
; Autor : volus
; Data  : 12/03/2007, 14:01:49
; Opis  : Podswietlanie przeroznych danych.
;

/def _sub = \
    /return substitute(strcat({PL}, {P0}, " ", decode_attr("@{Cgreen}%{*}@{n}"), {PR}))

; poziomy brutalnosci
/set    _tmp_kolor_hi=BCyellow

; poziomy doswiadczenia
/set    _tmp_kolor_hi=BCwhite

/eval /def -mregexp -P0%{_tmp_kolor_hi} -t'^Wyglada(|sz) na kompletnego zoltodzioba\.'                      _poziomy_doswiadczenia_1 = /_sub (1/17)
/eval /def -mregexp -P0%{_tmp_kolor_hi} -t'^Wyglada(|sz) na kogos, kto stawia pierwsze kroki\.'             _poziomy_doswiadczenia_2 = /_sub (2/17)
/eval /def -mregexp -P0%{_tmp_kolor_hi} -t'^Wyglada(|sz) na kogos, kto jeszcze niewiele widzial\.'          _poziomy_doswiadczenia_3 = /_sub (3/17)
/eval /def -mregexp -P0%{_tmp_kolor_hi} -t'^Wyglada(|sz) na kogos, kto niewiele wie o swiecie\.'            _poziomy_doswiadczenia_4 = /_sub (4/17)
/eval /def -mregexp -P0%{_tmp_kolor_hi} -t'^Wyglada(|sz) na kogos niedoswiadczonego\.'                      _poziomy_doswiadczenia_5 = /_sub (5/17)
/eval /def -mregexp -P0%{_tmp_kolor_hi} -t'^Wyglada(|sz) na kogos, kto widzial juz to i owo\.'              _poziomy_doswiadczenia_6 = /_sub (6/17)
/eval /def -mregexp -P0%{_tmp_kolor_hi} -t'^Wyglada(|sz) na kogos, kto pewnie stapa po swiecie\.'           _poziomy_doswiadczenia_7 = /_sub (7/17)
/eval /def -mregexp -P0%{_tmp_kolor_hi} -t'^Wyglada(|sz) na kogos, kto niejedno widzial\.'                  _poziomy_doswiadczenia_8 = /_sub (8/17)
/eval /def -mregexp -P0%{_tmp_kolor_hi} -t'^Wyglada(|sz) na kogos, kto swoje przezyl\.'                     _poziomy_doswiadczenia_9 = /_sub (9/17)
/eval /def -mregexp -P0%{_tmp_kolor_hi} -t'^Wyglada(|sz) na kogos (?!bardzo |wielce )doswiadczonego\.'      _poziomy_doswiadczenia_10= /_sub (10/17)
/eval /def -mregexp -P0%{_tmp_kolor_hi} -t'^Wyglada(|sz) na kogos, kto wiele przeszedl\.'                   _poziomy_doswiadczenia_11= /_sub (11/17)
/eval /def -mregexp -P0%{_tmp_kolor_hi} -t'^Wyglada(|sz) na kogos, kto widzial kawal swiata\.'              _poziomy_doswiadczenia_12= /_sub (12/17)
/eval /def -mregexp -P0%{_tmp_kolor_hi} -t'^Wyglada(|sz) na kogos bardzo doswiadczonego\.'                  _poziomy_doswiadczenia_13= /_sub (13/17)
/eval /def -mregexp -P0%{_tmp_kolor_hi} -t'^Wyglada(|sz) na kogos, kto zwiedzil caly swiat\.'               _poziomy_doswiadczenia_14= /_sub (14/17)
/eval /def -mregexp -P0%{_tmp_kolor_hi} -t'^Wyglada(|sz) na kogos wielce doswiadczonego\.'                  _poziomy_doswiadczenia_15= /_sub (15/17)
/eval /def -mregexp -P0%{_tmp_kolor_hi} -t'^Wyglada(|sz) na kogos, kto widzial i doswiadczyl wszystkiego\.' _poziomy_doswiadczenia_16= /_sub (16/17)
/eval /def -mregexp -P0%{_tmp_kolor_hi} -t'^Wyglada(|sz) na osobe owiana legenda\.'                         _poziomy_doswiadczenia_17= /_sub (17/17)

/def -ah -F -mregexp -t'Masz wrazenie, ze nie jest dla ciebie zadnym wyzwaniem'                                                 __ocena_nowa_1 = /_sub <1/10>
/def -ah -F -mregexp -t'Wyglada na marnego przeciwnika'                                                                         __ocena_nowa_2 = /_sub <2/10>
/def -ah -F -mregexp -t'Wydaje sie byc znacznie mniej sprawn(y|a|e) w walce od ciebie'                                          __ocena_nowa_3 = /_sub <3/10>
/def -ah -F -mregexp -t'Wydaje ci sie, ze jest troche mniej sprawn(y|a|e) w walce od ciebie'                                    __ocena_nowa_4 = /_sub <4/10>
/def -ah -F -mregexp -t'Wyglada na to, ze mozecie walczyc ze soba jak rowny z rownym'                                           __ocena_nowa_5 = /_sub <5/10>
/def -ah -F -mregexp -t'Zdaje sie byc troche bardziej sprawn(y|a|e) w walce niz ty'                                             __ocena_nowa_6 = /_sub <6/10>
/def -ah -F -mregexp -t'Wyglada na trudn(ego|a) przeciwni(ka|czke)'                                                             __ocena_nowa_7 = /_sub <7/10>
/def -ah -F -mregexp -t'Walka z ni(m|a) moze byc dla ciebie prawdziwym wyzwaniem'                                               __ocena_nowa_8 = /_sub <8/10>
/def -ah -F -mregexp -t'Masz marne szanse, by przetrwac walke z ni(m|a)'                                                        __ocena_nowa_9 = /_sub <9/10>
/def -ah -F -mregexp -t'Jesli tylko odwazysz sie na walke z ni(m|a), bedzie to najprawdopodobniej ostatnia walka w twoim zyciu' __ocena_nowa_10 = /_sub <10/10>

;[13:57:02:528382] # ==> poziomy jakosci broni
;[13:57:02:528560] # poziomy jakosci broni
;[13:57:02:552768] # Dostepne poziomy jakosci broni:    (Wyglada na to, ze)
;[13:57:02:552775] #    w znakomitym stanie, w dobrym stanie, liczne walki wyryly na niej
;[13:57:02:552778] #    swoje pietno, w zlym stanie, w bardzo zlym stanie, wymaga
;[13:57:02:552781] #    natychmiastowej konserwacji i moze peknac w kazdej chwili.

;[13:57:06:621039] # ==> poziomy jakosci zbroi
;[13:57:06:621238] # poziomy jakosci zbroi
;[13:57:06:646869] # Dostepne poziomy jakosci zbroi:
;[13:57:06:646876] #    w znakomitym stanie, lekko podniszczona, w kiepskim stanie, w
;[13:57:06:646880] #    oplakanym stanie i gotowa rozpasc sie w kazdej chwili.

;[13:57:09:489113] # ==> poziomy kaca
;[13:57:09:489305] # poziomy kaca
;[13:57:09:514304] # Dostepne poziomy kaca:
;[13:57:09:514309] #    lekkiego, niemilego, drazniacego, niezlego, straszliwego i
;[13:57:09:514311] #    potwornego.

;[13:57:22:117913] # ==> poziomy many
;[13:57:22:118069] # poziomy many
;[13:57:22:143564] # Dostepne poziomy many:
;[13:57:22:143569] #    u kresu sil, wykonczony, wyczerpany, w zlej kondycji, bardzo
;[13:57:22:143575] #    zmeczony, zmeczony, oslabiony, lekko oslabiony i w pelni sil.

;[13:57:32:005096] # ==> poziomy porownania sily
;[13:57:32:005257] # poziomy porownania sily
;[13:57:32:038278] # Dostepne poziomy porownania sily:
;[13:57:32:038283] #    rownie silny jak, troszeczke silniejszy niz, silniejszy niz i duzo
;[13:57:32:038286] #    silniejszy niz.

;[13:57:34:965261] # ==> poziomy porownania wytrzymalosci
;[13:57:34:965400] # poziomy porownania wytrzymalosci
;[13:57:34:988665] # Dostepne poziomy porownania wytrzymalosci:
;[13:57:34:988672] #    rownie dobrze zbudowany jak, troszeczke lepiej zbudowany niz,
;[13:57:34:988675] #    lepiej zbudowany niz i duzo lepiej zbudowany niz.

;[13:57:38:998293] # ==> poziomy porownania zrecznosci
;[13:57:38:998450] # poziomy porownania zrecznosci
;[13:57:39:023779] # Dostepne poziomy porownania zrecznosci:
;[13:57:39:023784] #    rownie zreczny jak, troszeczke zreczniejszy niz, zreczniejszy niz i
;[13:57:39:023786] #    duzo zreczniejszy niz.

;[13:57:41:773250] # ==> poziomy postepow
;[13:57:41:773463] # poziomy postepow
;[13:57:41:797797] # Dostepne poziomy postepow:
;[13:57:41:797805] #    minimalne, nieznaczne, bardzo male, male, nieduze, zadowalajace,
;[13:57:41:797808] #    spore, dosc duze, znaczne, duze, bardzo duze, ogromne, imponujace,
;[13:57:41:797811] #    wspaniale, gigantyczne i niebotyczne.

/def -F -mregexp -P0BCwhite;2uCcyan -t'^(Nie poczynil[ea]s|Poczynil[ea]s) (.*) postep(ow|y), od ((|momentu )kiedy) w(szed|esz)l[ea]s do gry'       _highlight_postepy = \
    /echo %; \
    /set _highlight_pokazuj_cechy=1%; \
    /if (_stat_ostatnie_postepy !~ {P2}) \
	/pecho Wskoczyly postepy! %; \
    /endif %; \
    /set _stat_ostatnie_postepy=%{P2}

/def -F -mregexp -E(_highlight_pokazuj_cechy) -P0BCwhite;1Cgreen;2Cgreen;3Cgreen;4Cgreen;5Cgreen;6Cgreen -t'^Jestes ([^,]*), ([^,]*), ([^,]*), ([^,]*), ([^ ]*) i ([^.]*)\.'   _highlight_cech = \
    /if (_stat_cecha_sil !~ {P1}) \
	/pecho Wskoczyla sila! %; \
    /endif %; \
    /if (_stat_cecha_zre !~ {P2}) \
	/pecho Wskoczyla zrecznosc! %; \
    /endif %; \
    /if (_stat_cecha_wyt !~ {P3}) \
	/pecho Wskoczyla wytrzymalosc! %; \
    /endif %; \
    /if (_stat_cecha_int !~ {P4}) \
	/pecho Wskoczyla inteligencja! %; \
    /endif %; \
    /if (_stat_cecha_mad !~ {P5}) \
	/pecho Wskoczyla madrosc! %; \
    /endif %; \
    /if (_stat_cecha_odw !~ {P6}) \
	/pecho Wskoczyla odwaga! %; \
    /endif %; \
    /set _stat_cecha_sil=%{P1} %; \
    /set _stat_cecha_zre=%{P2} %; \
    /set _stat_cecha_wyt=%{P3} %; \
    /set _stat_cecha_int=%{P4} %; \
    /set _stat_cecha_mad=%{P5} %; \
    /set _stat_cecha_odw=%{P6} %; \
    /set _highlight_pokazuj_brutalnosc=1 %; \
    /unset _highlight_pokazuj_cechy %; \

/def -F -mregexp -E(_highlight_pokazuj_brutalnosc) -P0BCwhite;1Cred -t'^Sadzac po twoim dotychczasowym zachowaniu, jestes ([^.]*)\.' _highlight_brutalnosc = \
    /set _stat_cecha_bru=%{P1} %; \
    /unset _highlight_pokazuj_brutalnosc %; \
    /repeat -0 1 /echo


;[13:57:44:895993] # ==> poziomy pragnienia
;[13:57:44:896150] # poziomy pragnienia
;[13:57:44:923866] # Dostepne poziomy pragnienia:
;[13:57:44:923874] #    chce ci sie bardzo pic, chce ci sie pic, troche chce ci sie pic i
;[13:57:44:923876] #    nie chce ci sie pic.

;[13:57:48:731434] # ==> poziomy przeciazenia
;[13:57:48:731586] # poziomy przeciazenia
;[13:57:48:762135] # Dostepne poziomy przeciazenia:
;[13:57:48:762143] #    ciezar twego ekwipunku wadzi ci troche, ciezar twego ekwipunku daje
;[13:57:48:762146] #    ci sie we znaki, ciezar twego ekwipunku jest dosyc klopotliwy, twoj
;[13:57:48:762149] #    ekwipunek jest wyjatkowo ciezki, twoj ekwipunek jest niemilosiernie
;[13:57:48:762152] #    ciezki i twoj ekwipunek prawie przygniata cie do ziemi.

;[13:57:53:868714] # ==> poziomy strachu
;[13:57:53:868860] # poziomy strachu
;[13:57:53:893831] # Dostepne poziomy strachu:
;[13:57:53:893835] #    bezpiecznie, spokojnie, nieswojo, nerwowo i przerazony.

;[13:57:56:313336] # ==> poziomy sytosci
;[13:57:56:313602] # poziomy sytosci
;[13:57:56:346504] # Dostepne poziomy sytosci:
;[13:57:56:346508] #    glodny i najedzony.

;[13:57:59:532570] # ==> poziomy umiejetnosci
;[13:57:59:532728] # poziomy umiejetnosci
;[13:57:59:556163] # Dostepne poziomy umiejetnosci:
;[13:57:59:556169] #    ledwo, troche, pobieznie, zadowalajaco, niezle, dobrze, znakomicie,
;[13:57:59:556172] #    doskonale, perfekcyjnie i mistrzowsko.

;[13:58:02:473626] # ==> poziomy upicia
;[13:58:02:473776] # poziomy upicia
;[13:58:02:498416] # Dostepne poziomy upicia:
;[13:58:02:498423] #    podchmielony, lekko podpity, podpity, wstawiony, mocno wstawiony,
;[13:58:02:498426] #    pijany, schlany, napruty, nawalony i pijany jak bela.

;[13:58:08:525307] # ==> poziomy zardzewienia
;[13:58:08:525461] # poziomy zardzewienia
;[13:58:08:550316] # Dostepne poziomy zardzewienia:
;[13:58:08:550323] #    brak komentarza, spostrzegasz slady rdzy, spostrzegasz liczne slady
;[13:58:08:550326] #    rdzy, jest cala pokryta rdza, wyglada jak po kapieli w kwasie i
;[13:58:08:550329] #    jest tak skorodowowana, ze moze rozpasc sie w kazdej chwili.

;[13:58:11:254703] # ==> poziomy zmeczenia
;[13:58:11:254854] # poziomy zmeczenia
;[13:58:11:278677] # Dostepne poziomy zmeczenia:
;[13:58:11:278684] #    w pelni wypoczety, wypoczety, troche zmeczony, zmeczony, bardzo
;[13:58:11:278687] #    zmeczony, nieco wyczerpany, wyczerpany, bardzo wyczerpany,
;[13:58:11:278689] #    wycienczony i calkowicie wycienczony.


;; ---------------- inne podswietlanie
/def -F -P0BCcyan -mregexp -t' (przybywa(ja|)[. ])'    _highlight_przybywa
/def -F -P0Ccyan  -mregexp -t' (podaza(ja|)[. ])'      _highlight_podaza
