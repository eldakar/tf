;
; Plik  : changelog.tf
; Autor : volus
; Data  : 07/06/2006, 15:29:36
; Opis  : /changelog :)
;

/eval /set _changelog_file=%{TFDIR}/changelog.txt

/def cl = /changelog %{*}

/def changelog = \
    /if ({*} =~ NULL) \
        /_changelog_pokaz %; \
    /elseif ({1} =~ "zapisz") \
        /_changelog_zapisz %{-1} %; \
    /else \
        /pecho Uzycie: /changelog NULL|zapisz %;\
    /endif

/def _changelog_pokaz = \
    /let _kolumny=$[columns()] %; \
    /pecho $[strrep("_", _kolumny - 5)]%; \
    /quote -S /_changelog_pokaz2 '%{_changelog_file} %; \
    /pecho |%; \
    /pecho |$[strrep("_", _kolumny - 6)]%; \

/def _changelog_pokaz2 = \
    /if ({1} !~ ";") \
        /if ({1} =~ "#") \
            /pecho | %; \
            /pecho | Dnia: %{-1} %; \
            /pecho | %; \
        /else \
            /let _txt=$(/pecho %{*}) %; \
            /let _max=$[_kolumny - 8]%; \
            /let _tmp=1 %; \
            /if (strlen(_txt) <= _max) \
                /echo %{_txt} %; \
            /else \
                /while (strlen(_txt) > _max) \
                    /let _ciach=$[strrchr(_txt, " ", _max)] %; \
                    /let _eline=$[substr(_txt, 0, _ciach)]  %; \
                    /let _txt=$[substr(_txt, _ciach + 1)] %; \
                    /if (_tmp == 1) \
                        /echo %{_eline} %; \
                        /let _tmp=2 %; \
                    /else \
                        /pecho |   %{_eline} %; \
                    /endif %; \
                    /if (strlen(_txt) <= _max) \
                        /pecho |   %{_txt} %; \
                    /endif %; \
                /done %; \
            /endif %; \
        /endif %; \
    /endif

/def _changelog_zapisz = \
    /if (_changelog_last_date =~ NULL) \
        /mesg -w Nie mam ustawionej ostatniej daty changeloga! Sprawdzam ja teraz... %; \
        /quote -S /_changelog_sprawdz_date '%{_changelog_file}%; \
        /if (_changelog_last_date =~ NULL) \
            /mesg -w Cos jest skopane z plikiem changeloga, sprawdz to! Nie znalazlem zadnej daty.%; \
        /else \
            /mesg -i Znalazlem date: %{_changelog_last_date} %; \
            /mesg -i Jeszcze raz uzyj komendy zapisz. %; \
        /endif %; \
    /else \
        /if ({*} =~ NULL) \
            /mesg -i Uzycie: /changelog zapisz Informacja %; \
            /return %; \
        /endif %; \
        /if (_changelog_last_date =~ ftime("%d-%m-%Y")) \
            /echo | - %{*} %| /writefile -a %{_changelog_file}%; \
        /else \
            /echo # $[ftime("%d-%m-%Y")] %| /writefile -a %{_changelog_file}%; \
            /echo | - %{*} %| /writefile -a %{_changelog_file}%; \
            /set _changelog_last_date=$[ftime("%d-%m-%Y")]%; \
        /endif%; \
        /pecho Zapisalem informacje do pliku changelogu... %; \
    /endif %; \

/def _changelog_sprawdz_date = \
    /if ({1} =~ "#") \
        /set _changelog_last_date=%{2}%; \
    /endif

/_changelog_zapisz

; Nowosc    @{BCgreen}
; Zmiany    @{BCwhite}
; Usuniecie @{BCred}
;
