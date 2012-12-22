;
; Plik  : bufor.tf
; Autor : volus
; Data  : 12/05/2006, 01:34:20
; Opis  : /buf, /buf_end powiedz, co tu duzo tlumaczyc :)
;

/def purge_bufor_lines = \
    /quote -S /purge_bufor_line `"/listvar -s bufor_line_*"

/def purge_bufor_line = \
    /unset %{1}

/def buf = /bufor %{*}
/def bufor = \
    /purge_bufor_lines%;\
    /set bufor_line_last_id=1%;\
    /def -F -p%{maxpri} -h'SEND' _hook_send = \
        /set bufor_line_%%{bufor_line_last_id}=%%{*}%%;\
        /test ++bufor_line_last_id

/def be = /buf_end %{*}
/def buf_end = \
    /undef _hook_send%;\
    /for i 1 %{bufor_line_last_id}-1 \
        /eval /send %{*} %%%{bufor_line_%%{i}}
