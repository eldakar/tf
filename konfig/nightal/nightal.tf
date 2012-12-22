;
; Plik  : nightal.tf
; Autor : volus
; Data  : 26/06/2006, 02:24:20
; Opis  :
;

;;; ladujemy skrypt sprzetu;
;;;

/load nightal_sprzet.tf

;;; skrypt sprzedazy skor
/load nightal_skory.tf
/load nightal_kon.tf

/load nightal_dylizans.tf

;;;==========================


; ----------------- ciosy
;   oddzielne sa dla bludgeon, slash i impale, ale wrzuce to w jeden def
; -----------------
/def -F -P0BCcyan -mregexp -t'^(muskasz|ledwie zadrapujesz|tylko nacinasz|ledwie ranisz|\
                                lekko obijasz|zadrapujesz|nacinasz|lekko ranisz|\
                                obijasz|lekko tniesz|dzgasz|lekko ranisz|\
                                tluczesz|tniesz|klujesz|ranisz|\
                                powaznie obijasz|powaznie tniesz|powaznie klujesz|ranisz|\
                                uderzasz|gleboko tniesz|gleboko klujesz|powaznie ranisz|\
                                mocno uderzasz|bardzo mocno tniesz|masakrycznie roz(s|)cinasz|bardzo ciezko ranisz|\
                                brutalnie tluczesz|smiercionosnie tniesz|wsciekle roz(s|)cinasz|krytycznie ranisz)'   _nightal_ciosy_1

/def -F -PLBCwhite;1Ccyan -mregexp -t'\
    (muska|ledwie zadrapuje|tylko nacina|ledwie rani|\
     lekko obija|zadrapuje|nacina|lekko rani|\
     obija|lekko tnie|dzga|lekko rani|\
     tlucze|tnie|kluje|rani|\
     powaznie obija|powaznie tnie|powaznie kluje|rani|\
     uderza|gleboko tnie|gleboko kluje|powaznie rani|\
     mocno uderza|bardzo mocno tnie|masakrycznie roz(s|)cina|bardzo ciezko rani|\
     brutalnie tlucze|smiercionosnie tnie|wsciekle roz(s|)cina|krytynie rani) (?!cie )'      _nightal_ciosy_2

/def -F -PLBCwhite;1BCcyan -mregexp -t'\
    (muska|ledwie zadrapuje|tylko nacina|ledwie rani|\
     lekko obija|zadrapuje|nacina|lekko rani|\
     obija|lekko tnie|dzga|lekko rani|\
     tlucze|tnie|kluje|rani|\
     powaznie obija|powaznie tnie|powaznie kluje|rani|\
     uderza|gleboko tnie|gleboko kluje|powaznie rani|\
     mocno uderza|bardzo mocno tnie|masakrycznie roz(s|)cina|bardzo ciezko rani|\
     brutalnie tlucze|smiercionosnie tnie|wsciekle roz(s|)cina|krytynie rani) cie '         _nightal_ciosy_3 = \
    \
    /substitute -p %{PL}$[toupper({P0})]%{PR}



;;;;;;;;----------------- hility wszelakie
;;;;;;;;;

/def _hil = \
    /return substitute(strcat({PL}, {P0}, {PR}, ' ', {*}), "x", 1)

;;;;;;;;;;; lvl

;* 18 lvli

;* zagubiony mlokos,
;* zagubiona mlodka,
/def -F -aBCwhite -mregexp -t'zagubion(a|ego) mlo(dke|kosa)'                                _nightal_hilite_lvl_1 = /_hil @{nCgreen}[ 1/18]

;* niedorajda stawiajacy piersze kroki na traktach,
;* niedorajda stawiajaca piersze kroki na traktach,
/def -F -aBCwhite -mregexp -t'niedorajde stawiajac(a|ego) pier(w|)sze kroki na traktach'    _nightal_hilite_lvl_2 = /_hil @{nCgreen}[ 2/18]

;* nieobeznany z drogami wojazer,
;* nieobeznana z drogami wojazerka,
/def -F -aBCwhite -mregexp -t'nieobeznan(a|ego) z droga wojazer(ke|a)'                      _nightal_hilite_lvl_3 = /_hil @{nCgreen}[ 3/18]

;* ciekawy przygod wedrowiec,
;* ciekawa przygod wedrowczyni,
/def -F -aBCwhite -mregexp -t'ciekaw(a|ego) przygod wedrowc(zyni|a)'                        _nightal_hilite_lvl_4 = /_hil @{nCgreen}[ 4/18]

;* podroznik przebywajacy trakty,
;* podrozniczka przebywajaca trakty,
/def -F -aBCwhite -mregexp -t'podrozni(czke|ka) przebywajac(a|ego) trakty'                  _nightal_hilite_lvl_5 = /_hil @{nCgreen}[ 5/18]

;* chwat badajacy kazdy zakatek swiata,
;* chwatka badajaca kazdy zakatek swiata,
/def -F -aBCwhite -mregexp -t'chwat(ke|a) badajac(a|ego) kazdy zakatek swiata'              _nightal_hilite_lvl_6 = /_hil @{nCgreen}[ 6/18]

;* znany w gospodach wedrowiec,
;* znana w gospodach wedrowczyni,
/def -F -aBCwhite -mregexp -t'znan(a|ego) w gospodach wedrowc(zyni|a)'                      _nightal_hilite_lvl_7 = /_hil @{nCgreen}[ 7/18]

;* obeznany ze swiatem wedrowiec,
;* obeznana ze swiatem wedrowczyni,
/def -F -aBCwhite -mregexp -t'obeznan(a|ego) ze swiatem wedrowc(zyni|a)'                    _nightal_hilite_lvl_8 = /_hil @{nCgreen}[ 8/18]

;* podroznik o swiatowej slawie,
;* podrozniczka o swiatowej slawie,
/def -F -aBCwhite -mregexp -t'podrozni(czke|ka) o swiatowej slawie'                         _nightal_hilite_lvl_9 = /_hil @{nCgreen}[ 9/18]

;* weteran przemierzajacy swiat,
;* weteranka przemierzajaca swiat,
/def -F -aBCwhite -mregexp -t'weteran(ke|a) przemierzajac(a|ego) swiat'                     _nightal_hilite_lvl_10= /_hil @{nCgreen}[10/18]

;* bohater zdobywajacy slawe w swiecie,
;* bohaterka zdobywajaca slawe w swiecie,
/def -F -aBCwhite -mregexp -t'bohater(ke|a) zdobywajac(a|ego) slawe w swiecie'              _nightal_hilite_lvl_11= /_hil @{nCgreen}[11/18]

;* niedoceniony w swiecie bohater,
;* niedoceniona w swiecie bohaterka,
/def -F -aBCwhite -mregexp -t'niedocenion(a|ego) w swiecie bohater(ke|a)'                   _nightal_hilite_lvl_12= /_hil @{nCgreen}[12/18]

;* wielce doswiadczony bohater,
;* wielce doswiadczona bohaterka,
/def -F -aBCwhite -mregexp -t'wielce doswiadczon(a|ego) bohater(ke|a)'                      _nightal_hilite_lvl_13= /_hil @{nCgreen}[13/18]

;* chwalony w swiecie bohater,
;* chwalona w swiecie bohaterka,
/def -F -aBCwhite -mregexp -t'chwalon(a|ego) w swiecie bohater(ke|a)'                       _nightal_hilite_lvl_14= /_hil @{nCgreen}[14/18]

;* oslawiony w piesniach bohater,
;* oslawiona w piesniach bohaterka,
/def -F -aBCwhite -mregexp -t'oslawion(a|ego) w piesniach bohater(ke|a)'                    _nightal_hilite_lvl_15= /_hil @{nCgreen}[15/18]

;* znajacy niemalze kazda tajemnice bohater,
;* znajaca niemalze kazda tajemnice bohaterka,
/def -F -aBCwhite -mregexp -t'znajac(a|ego) niemalze kazda tajemnice bohater(ke|a)'         _nightal_hilite_lvl_16= /_hil @{nCgreen}[16/18]

;* bohater dla ktorego swiat nie ma tajemnic
;* bohaterka dla ktorej swiat nie ma tajemnic
/def -F -aBCwhite -mregexp -t'bohater(ke|a) dla ktore(j|go) swiat nie ma tajemnic'          _nightal_hilite_lvl_17= /_hil @{nCgreen}[17/18]

;* taki co w pojedynke moglby pokonac smoka.
;* taka co w pojedynke moglaby pokonac smoka.
/def -F -aBCwhite -mregexp -t'tak(a|iego) co w pojedynke mogl(a|)by pokonac smoka'          _nightal_hilite_lvl_18= /_hil @{nCgreen}[18/18]

;;;;  POSTEPY
/def -F -aBCwhite -mregexp -t'^Poczynil[ea]s (.*) postepy, od momentu kiedy (wszedles|weszlas) do gry\.$'  _nightal_hilite_postepy = \
    /if     ({P1} =~ "znikome")     /_hil @{nCgreen}[1/8]%; \
    /elseif ({P1} =~ "nieznaczne")  /_hil @{nCgreen}[2/8]%; \
    /elseif ({P1} =~ "male")        /_hil @{nCgreen}[3/8]%; \
    /elseif ({P1} =~ "nieduze")     /_hil @{nCgreen}[4/8]%; \
    /elseif ({P1} =~ "znaczne")     /_hil @{nCgreen}[5/8]%; \
    /elseif ({P1} =~ "duze")        /_hil @{nCgreen}[6/8]%; \
    /elseif ({P1} =~ "wspaniale")   /_hil @{nCgreen}[7/8]%; \
    /elseif ({P1} =~ "ogromne")     /_hil @{nCgreen}[8/8]%; \
    /else                           /_hil @{nCgreen}[?/?]%; \
    /endif
    


;;;;;;;;;;;;;;;;;
;; standard dla cech:
;; /test dodaj_hilite_cechy("Opis w regexpie", "@{kolor}[lvl/lvl]")
/purge _nightal_hilite_cecha_*
/unset _nightal_cecha

/def dodaj_hilite_cechy = \
    /test ++_nightal_cecha %;\
    /def -F -aBCwhite -mregexp -t'%{1}'     _nightal_hilite_cecha_%{_nightal_cecha} = \
        /substitute -p %{2}@{n} %%{PL}%%{P0}%%{PR}


;Dostepne poziomy sily:
/test dodaj_hilite_cechy("^Powiadaja o tobie jakobys byl slabszy niz kot\.",                            "@{Cgreen}[ 1/17]@{n}")
/test dodaj_hilite_cechy("^Mowia, iz z trudem dzwigasz wiadro z woda\n",                                "@{Cgreen}[ 2/17]@{n}")
/test dodaj_hilite_cechy("^Uginasz sie pod ciezarem kazdego oburecznego oreza\.",                       "@{Cgreen}[ 3/17]@{n}")
/test dodaj_hilite_cechy("^Potrafisz cisnac na calkiem spora odleglosc stolkiem w karczemnej burdzie\.","@{Cgreen}[ 4/17]@{n}")
/test dodaj_hilite_cechy("^Bez wysilku potrafisz dzwigac nawet naprawde ciezkie przedmioty\.",          "@{Cgreen}[ 5/17]@{n}")
/test dodaj_hilite_cechy("^Potrafisz wladac nawet najwieksza bronia\.",                                 "@{Cgreen}[ 6/17]@{n}")
/test dodaj_hilite_cechy("^Potrafilbys nauczyc grzecznosci najwiekszego, karczemnego osilka\.",          "@{Cgreen}[ 7/17]@{n}")
/test dodaj_hilite_cechy("^Uchodzisz za mistrza pojedynkow na reke\.",                                  "@{Cgreen}[ 8/17]@{n}")
/test dodaj_hilite_cechy("^Jestes silny niczym gorski niedzwiedz\.",                                    "@{Cgreen}[ 9/17]@{n}")
/test dodaj_hilite_cechy("^Z latwoscia zginasz w rekach podkowy\.",                                     "@{Cgreen}[10/17]@{n}")
/test dodaj_hilite_cechy("^Czujesz sie tak silny, iz moglbys uniesc woz z koniem!",                     "@{Cgreen}[11/17]@{n}")
/test dodaj_hilite_cechy("^Masz w sobie sile dziesieciu mezow\.",                                       "@{Cgreen}[12/17]@{n}")
/test dodaj_hilite_cechy("^Masz w sobie sile najslawniejszych herosow\.",                               "@{Cgreen}[13/17]@{n}")
/test dodaj_hilite_cechy("^Najpotezniejsze biesy obawiaja sie mierzyc sie z toba na reke\.",            "@{Cgreen}[14/17]@{n}")
/test dodaj_hilite_cechy("^Twoja niezwykla sila przeszla do legendy\.",                                 "@{Cgreen}[15/17]@{n}")
/test dodaj_hilite_cechy("^Najmocarniejsze byty Faerunu zazdroszcza ci twej wspanialej sily\.",         "@{Cgreen}[16/17]@{n}")
/test dodaj_hilite_cechy("^Bez cienia leku powiadaja, iz jestes potezniejszy niz sami bogowie!",        "@{Cgreen}[17/17]@{n}")

;Dostepne poziomy zrecznosci:
/test dodaj_hilite_cechy("^Potrafisz wywrocic sie nawet na calkiem prostej drodze\.",                           "@{Cgreen}[ 1/17]@{n}")
/test dodaj_hilite_cechy("^Lepiej bedzie nie dawac ci do rak procy\.\.\.",                                      "@{Cgreen}[ 2/17]@{n}")
/test dodaj_hilite_cechy("^Balansowanie na waskich powierzchniach nie jest twoja mocna strona\.\.\.",           "@{Cgreen}[ 3/17]@{n}")
/test dodaj_hilite_cechy("^Bez wiekszych problemow trafiasz kamieniem do celu\.",                               "@{Cgreen}[ 4/17]@{n}")
/test dodaj_hilite_cechy("^Bylbys w stanie balansowac na rejach niczym doswiadczony zeglarz\.",                 "@{Cgreen}[ 5/17]@{n}")
/test dodaj_hilite_cechy("^Gdybys zechcial, moglbys spokojnie naciagac mieszczuchow w grze w \'trzy kubki\'\.", "@{Cgreen}[ 6/17]@{n}")
/test dodaj_hilite_cechy("^Swa zrecznoscia dorownujesz zwinnosci cyrkowcow i zonglerow\.",                      "@{Cgreen}[ 7/17]@{n}")
/test dodaj_hilite_cechy("^Plotka glosi, iz zestrzelilbys jablko z glowy wlasnego syna\.",                      "@{Cgreen}[ 8/17]@{n}")
/test dodaj_hilite_cechy("^Powiadaja, iz masz kocia zrecznosc i ze zawsze spadasz na cztery lapy\.",            "@{Cgreen}[ 9/17]@{n}")
/test dodaj_hilite_cechy("^Masz refleks akrobaty z prawdziwego zdarzenia\.",                                    "@{Cgreen}[10/17]@{n}")
/test dodaj_hilite_cechy("^Jestes w stanie przescignac pedzacy dylizans\.",                                     "@{Cgreen}[11/17]@{n}")
/test dodaj_hilite_cechy("^Jestes szybki niczym wiatr\.",                                                       "@{Cgreen}[12/17]@{n}")
/test dodaj_hilite_cechy("^Masz w sobie zrecznosc powietrznego zywiolaka\.",                                    "@{Cgreen}[13/17]@{n}")
/test dodaj_hilite_cechy("^Bajarze powiadaja, iz potrafisz pochwycic strzale w locie\.",                        "@{Cgreen}[14/17]@{n}")
/test dodaj_hilite_cechy("^Twa zadziwiajaca zrecznosc figuruje na kartach legend\.",                            "@{Cgreen}[15/17]@{n}")
/test dodaj_hilite_cechy("^Mowia, iz potrafisz skoczyc dalej niz siega ludzki wzrok\.",                         "@{Cgreen}[16/17]@{n}")
/test dodaj_hilite_cechy("^Potrafilbys uchylic sie przed ciosem przedwiecznych\.",                              "@{Cgreen}[17/17]@{n}")

;Dostepne poziomy wytrzymalosci:
/test dodaj_hilite_cechy("^Przypominasz swa postura rachityczne drzewko\.",                             "@{Cgreen}[ 1/17]@{n}")
/test dodaj_hilite_cechy("^Mowia, ze jestes kruchy niczym szklo\.",                                     "@{Cgreen}[ 2/17]@{n}")
/test dodaj_hilite_cechy("^Kielich wina potrafi zwalic cie z nog\. A co dopiero cios maczugi?",         "@{Cgreen}[ 3/17]@{n}")
/test dodaj_hilite_cechy("^Bez wiekszego wyczerpania pokonujesz marszem dlugie dystanse\.",             "@{Cgreen}[ 4/17]@{n}")
/test dodaj_hilite_cechy("^Jedno uderzenie kuflem nie wystarczy by zwalic cie z nog\.",                 "@{Cgreen}[ 5/17]@{n}")
/test dodaj_hilite_cechy("^Dalekie, wyczerpujace marsze sa dla ciebie lekka codziennoscia\.",           "@{Cgreen}[ 6/17]@{n}")
/test dodaj_hilite_cechy("^Nie tak latwo zwalic cie pod stol\.",                                        "@{Cgreen}[ 7/17]@{n}")
/test dodaj_hilite_cechy("^Bez wytchnienia potrafisz pokonac biegiem spore dystanse\.",                 "@{Cgreen}[ 8/17]@{n}")
/test dodaj_hilite_cechy("^Mowia, iz masz skore tak gruba niczym pancerz ankhega\.",                    "@{Cgreen}[ 9/17]@{n}")
/test dodaj_hilite_cechy("^Masz w sobie dosc wytrzymalosci, by zatrzymac szarzujacego byka!",           "@{Cgreen}[10/17]@{n}")
/test dodaj_hilite_cechy("^Mawiaja, iz mierzysz sie na bary z poteznymi niedzwiedziami\.",              "@{Cgreen}[11/17]@{n}")
/test dodaj_hilite_cechy("^Niejeden gladiator zazdrosci ci niezwyklej wytrzymalosci\.",                 "@{Cgreen}[12/17]@{n}")
/test dodaj_hilite_cechy("^Jestes twardy niczym blok granitu\.",                                        "@{Cgreen}[13/17]@{n}")
/test dodaj_hilite_cechy("^Mowia, iz pioruny czynia na twej skorze tylko lekkie oparzenia\.",           "@{Cgreen}[14/17]@{n}")
/test dodaj_hilite_cechy("^Piesni opiewaja twa nadzwyczajna wytrzymalosc\.",                            "@{Cgreen}[15/17]@{n}")
/test dodaj_hilite_cechy("^Niektorzy twierdza, ze podroz do Otchlani bylaby dla ciebie spacerkiem\.",   "@{Cgreen}[16/17]@{n}")
/test dodaj_hilite_cechy("^Jestes w stanie przyjac na siebie cios samej opatrznosci\.",                 "@{Cgreen}[17/17]@{n}")

;Dostepne poziomy inteligencji:
/test dodaj_hilite_cechy("^Powiadaja, ze jestes bystry jak woda w bajorze\.",                               "@{Cgreen}[ 1/17]@{n}")
/test dodaj_hilite_cechy("^Z trudem potrafisz napisac bez bledu kilka slow\.",                              "@{Cgreen}[ 2/17]@{n}")
/test dodaj_hilite_cechy("^Mawiaja, ze dorownujesz intelektem bystrosci wioskowych idiotow\.",              "@{Cgreen}[ 3/17]@{n}")
/test dodaj_hilite_cechy("^Prostych obliczen dokonujesz w pamieci\.",                                       "@{Cgreen}[ 4/17]@{n}")
/test dodaj_hilite_cechy("^Plotka glosi, ze jestes bardzo sprytny i przebiegly\.",                          "@{Cgreen}[ 5/17]@{n}")
/test dodaj_hilite_cechy("^Swym intelektem potrafilbys z niejednego uczynic glupca\.",                      "@{Cgreen}[ 6/17]@{n}")
/test dodaj_hilite_cechy("^Z latwoscia rozwiazalbys kazda zagadke\.",                                       "@{Cgreen}[ 7/17]@{n}")
/test dodaj_hilite_cechy("^Uchodzisz za niestrudzonego odkrywce\. Swiat skrywa jeszcze wiele tajemnic\.",   "@{Cgreen}[ 8/17]@{n}")
/test dodaj_hilite_cechy("^Wladasz ogromna wiedza, lecz jeszcze wiele nauki przed toba\.",                  "@{Cgreen}[ 9/17]@{n}")
/test dodaj_hilite_cechy("^Niektorzy mowia, iz potrafisz przetlumaczyc kazdy manuskrypt\.",                 "@{Cgreen}[10/17]@{n}")
/test dodaj_hilite_cechy("^Swym niezwyklym intelektem przycmiewasz wielu uczonych\.",                       "@{Cgreen}[11/17]@{n}")
/test dodaj_hilite_cechy("^Mowia, iz swiat nie ma przed toba zadnych tajemnic\.",                           "@{Cgreen}[12/17]@{n}")
/test dodaj_hilite_cechy("^Najwieksi medrcy Faerunu zazdroszcza ci bystrosci umyslu\.",                     "@{Cgreen}[13/17]@{n}")
/test dodaj_hilite_cechy("^Biegle poslugujesz sie nawet najbardziej zapomnianymi jezykami\.",               "@{Cgreen}[14/17]@{n}")
/test dodaj_hilite_cechy("^O twym niezwyklym intelekcie opowiadaja najwieksze ksiegi madrosci\.",           "@{Cgreen}[15/17]@{n}")
/test dodaj_hilite_cechy("^Najslynniejsi geniusze zywiolow obawiaja sie mierzyc z twoim intelektem\.",      "@{Cgreen}[16/17]@{n}")
/test dodaj_hilite_cechy("^Swym umyslem ogarniasz nawet boskie tajemnice\.",                                "@{Cgreen}[17/17]@{n}")

;Dostepne poziomy madrosci:
/test dodaj_hilite_cechy("^Nawet dziecko oszukaloby cie bez trudu\.",                                       "@{Cgreen}[ 1/17]@{n}")
/test dodaj_hilite_cechy("^Z trudem podejmujesz najprostsze decyzje\.",                                     "@{Cgreen}[ 2/17]@{n}")
/test dodaj_hilite_cechy("^Nawet nieskomplikowane wybory wymagaja od ciebie zaciagniecia rady\.",           "@{Cgreen}[ 3/17]@{n}")
/test dodaj_hilite_cechy("^Samodzielnie dokonujesz zyciowych wyborow\.",                                    "@{Cgreen}[ 4/17]@{n}")
/test dodaj_hilite_cechy("^Potrafisz przytomnie ocenic prawie kazda sytuacje\.",                            "@{Cgreen}[ 5/17]@{n}")
/test dodaj_hilite_cechy("^Zdarzaja sie i tacy, ktorzy zwracaja sie do ciebie o pomoc w trudnej sytuacji\.","@{Cgreen}[ 6/17]@{n}")
/test dodaj_hilite_cechy("^Posiadasz dary rozumu oraz madrosci\.",                                          "@{Cgreen}[ 7/17]@{n}")
/test dodaj_hilite_cechy("^Niektorzy uwazaja cie za wspanialego rozjemce w trudnych sporach\.",             "@{Cgreen}[ 8/17]@{n}")
/test dodaj_hilite_cechy("^Wiesz wiele o roznych sprawach \- zarowno boskich jak i calkiem przyziemnych\.", "@{Cgreen}[ 9/17]@{n}")
/test dodaj_hilite_cechy("^Zdolales w swym zyciu poznac dokladnie wiele dziedzin wiedzy\.",                 "@{Cgreen}[10/17]@{n}")
/test dodaj_hilite_cechy("^Masz niezwykly talent do zawsze obierania wlasciwej drogi\.",                    "@{Cgreen}[11/17]@{n}")
/test dodaj_hilite_cechy("^Wielu prostych smiertelnikow zaciaga u ciebie rady\.",                           "@{Cgreen}[12/17]@{n}")
/test dodaj_hilite_cechy("^Uchodzisz za prawdziwa ostoje madrosci\.",                                       "@{Cgreen}[13/17]@{n}")
/test dodaj_hilite_cechy("^Powiadaja, iz nie ma sytuacji, z ktorej nie znalazlbys wyjscia\.",               "@{Cgreen}[14/17]@{n}")
/test dodaj_hilite_cechy("^Twa madrosc znalazla dla siebie trwale miejsce na kartach historii\.",           "@{Cgreen}[15/17]@{n}")
/test dodaj_hilite_cechy("^Powiadaja, ze tylko ty potrafilbys zakonczyc Wojne Krwi\.",                      "@{Cgreen}[16/17]@{n}")
/test dodaj_hilite_cechy("^Swym rozumem potrafisz rozsadzac nawet boskie spory\.",                          "@{Cgreen}[17/17]@{n}")

;Dostepne poziomy odwagi:
/test dodaj_hilite_cechy("^Jestes plochliwszy od myszy\.",                                                              "@{Cgreen}[ 1/17]@{n}")
/test dodaj_hilite_cechy("^Boisz sie wlasnego cienia\.",                                                                "@{Cgreen}[ 2/17]@{n}")
/test dodaj_hilite_cechy("^Wystrzegasz sie ciemnych puszcz i opuszczonych zamczysk\.",                                  "@{Cgreen}[ 3/17]@{n}")
/test dodaj_hilite_cechy("^Od dawna nie obawiasz sie ciemnosci\.",                                                      "@{Cgreen}[ 4/17]@{n}")
/test dodaj_hilite_cechy("^Nie lekasz sie dzikich puszcz czy niezbadanych gor\. Co innego mieszkajacych wen bestii\.",  "@{Cgreen}[ 5/17]@{n}")
/test dodaj_hilite_cechy("^Potrafilbys bez cienia strachu stanac przeciwko rownemu sobie przeciwnikowi\.",              "@{Cgreen}[ 6/17]@{n}")
/test dodaj_hilite_cechy("^Nie pierwszyzna sa dla ciebie potyczki\.",                                                   "@{Cgreen}[ 7/17]@{n}")
/test dodaj_hilite_cechy("^Niektorzy powiadaja, iz nie zlaklbys sie umbrowego kolosa, stajac tuz przed nim\.",          "@{Cgreen}[ 8/17]@{n}")
/test dodaj_hilite_cechy("^Sa ludzie, ktorzy poszliby za toba w ogien\.",                                               "@{Cgreen}[ 9/17]@{n}")
/test dodaj_hilite_cechy("^Nie obawiasz sie zadnych niebezpieczenstw\.",                                                "@{Cgreen}[10/17]@{n}")
/test dodaj_hilite_cechy("^Nie pamietasz juz kiedy ostatnim razem zmrozil cie strach\.",                                "@{Cgreen}[11/17]@{n}")
/test dodaj_hilite_cechy("^Za nic masz wszelkie niebezpieczenstwa\.",                                                   "@{Cgreen}[12/17]@{n}")
/test dodaj_hilite_cechy("^Nie ma bestii, ktorej moglbys sie zleknac!",                                                 "@{Cgreen}[13/17]@{n}")
/test dodaj_hilite_cechy("^Byc moze inni obawiaja sie smokow\.\.\.",                                                    "@{Cgreen}[14/17]@{n}")
/test dodaj_hilite_cechy("^Twoja nadludzka odwaga obrosla z czasem w legende\.",                                        "@{Cgreen}[15/17]@{n}")
/test dodaj_hilite_cechy("^Nie poczulbys trwogi stajac nawet naprzeciw goristro\.",                                     "@{Cgreen}[16/17]@{n}")
/test dodaj_hilite_cechy("^Nie balbys sie splunac w twarz boskim opiekunom\.",                                          "@{Cgreen}[17/17]@{n}")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

/def oc = \
    medytuj %; \
    ocen sile %; \
    ocen zrecznosc %; \
    ocen wytrzymalosc %; \
    ocen inteligencje %; \
    ocen madrosc %; \
    ocen odwage %; \
    powstan

/def podziel = \
    otworz mieszek %; \
    \
    daj zlota monete fritzowi %; \
    daj zlota monete renowi %; \
    wloz zlota monete do mieszka %; \
    \
    daj srebrna monete fritzowi %; \
    daj srebrna monete renowi %; \
    wloz srebrna monete do mieszka %; \
    \
    zamknij mieszek

/def ub = \
    otworz plecak %; \
    /db %; \
    wez wszystkie zbroje z plecaka %; \
    zaloz wszystkie zbroje %; \
    napelnij plecak %; \
    zamknij plecak %; \

/def roz = \
    otworz plecak %; \
    /op %; \
    zdejmij wszystkie zbroje %; \
    napelnij plecak %; \
    wloz wszystkie zbroje do plecaka %; \
    zamknij plecak %; \

/alias start_nightal \
    zaloz wszystkie ubrania %; \
    zaloz plecak %; \
    przypnij pochwe w pasie %; \
    przypnij temblak w pasie %; \
    otw %; \
    wlm %; \
    /op1 %; \
    /op2 %; \
    napelnij plecak %; \
    zmk

;;; standardowo dobywamy bron oznaczona jako pierwsza, druga bron to alternative
/def db = /db1
/def op = /op1

/def por = \
    porownaj sile z %* %; \
    porownaj zrecznosc z %* %; \
    porownaj wytrzymalosc z %*

/def key_nkp/ = \
    /mesg Ubieram sie!%; \
    /ub

/def key_nkp* = \
    /mesg Rozbieram sie!%; \
    /roz

/alias zpk \
    uderz w brame %; \
    pociagnij za sznurek %; \
    zapukaj we wrota


/def kowal = \
    naostrz bron %; \
    naostrz druga bron %; \
    naostrz trzecia bron %; \
    \
    napraw zbroje %; \
    napraw druga zbroje %; \
    napraw trzecia zbroje %; \
    napraw czwarta zbroje %; \
    napraw piata zbroje %; \
    napraw szosta zbroje %; \
    napraw siodma zbroje %; \
    napraw osma zbroje %; \
    napraw dziewiata zbroje %; \
    napraw dziesiata zbroje

/def -PLBCwhite;0BCred;RBCmagenta -F -mregexp -t'atakuje (?!cie )' _atak_nie_mnie

;/alias po \
;    /mow_zaciagajac %{*}

;/def mow_zaciagajac = \
;    /send ':zaciagajac monotonnie: $[replace("a", strrep("a", rand(1,4)), \
;				     replace("o", strrep("o", rand(1,4)), \
;				     replace("e", strrep("e", rand(1,4)), {*})))]

/alias zpp zapal pochodnie
/alias zgp zgas zapalona pochodnie
/alias odp odloz wypalona pochodnie

/alias zpl zapal lampe
/alias zgl zgas lampe
/alias napl napelnij lampe olejem z butelki

;/f4 wytnij skore z ciala %; otworz plecak %; wloz skory do plecaka %; zamknij plecak
;/f4 wytnij skore z ciala %; /wl skory 
/f4 /op %; /wz sztylet %; dobadz sztyletu %; wytnij skore z ciala %; /wl sztylet i skory %; /db

/def -aB -F -mregexp -t'^Gdzie chcesz usiasc\? Moze (.*)\? W razie watpliwosci' _siadanie = \
    /set _siedzenie=%{P1} %; \
    /substitute -p %{P0}%{PR} @{Cgreen}(/us = usiadz %{P1})

/def us = usiadz %{_siedzenie}

/def wyt = \
    wytnij serce z %* ciala %; \
    wytnij watrobe z %* ciala %; \
    /repeat -0 2 wytnij nerke z %* ciala %; \
    wytnij ogon z %* ciala

/def med = \
    medytuj %; \
    ocen sile %; \
    ocen zrecznosc %; \
    ocen wytrzymalosc %; \
    \
    ocen inteligencje %; \
    ocen madrosc %; \
    ocen odwage %; \
    powstan
