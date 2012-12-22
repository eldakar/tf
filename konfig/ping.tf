;
; Plik  : ping.tf
; Autor : volus
; Data  : 15/09/2007, 16:02:08
; Opis  : Krociutki skrypcik ktory bedzie pokazywal na biezaco
;         jaki jest ping do muda... (dziala tylko na mudach LP)
;

/set _lag=0

/def _stworz_send_hook = \
    /def -p0 -F -h"SEND" _lag_checker = \
        /eval /set _time=$$[time()] %%; \
        /undef _lag_checker %%; \
;        /echo Ustawilem zmienna time: %{_time} %%; \
        %%{*} %%; \
        /repeat -0.01 1 /_stworz_send_hook 

/_stworz_send_hook

/def -F -h"PROMPT *> " _sprawdz_lag = \
    /let _ttime=$[(time() - _time) * 1000] %; \
;    /echo Sprawdzam lag! ($[time()] - %{_time}) %; \
    /if (_ttime < 200) \
        /eval /set _lag=$$[decode_attr("@{Cgreen}%{_ttime}@{n}")] %; \
    /elseif (_ttime < 2000) \
        /eval /set _lag=$$[decode_attr("@{Cyellow}%{_ttime}@{n}")] %; \
    /elseif (_ttime < 10000) \
        /eval /set _lag=$$[decode_attr("@{Cred}%{_ttime}@{n}")] %; \
    /else \
        /eval /set _lag=$$[decode_attr("@{BCmagenta}%{_ttime}@{n}")] %; \
    /endif %; \
    
