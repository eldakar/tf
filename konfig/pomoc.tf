;
; Plik  : pomoc.tf
; Autor : volus
; Data  : 05/01/2011, 11:42
; Opis  : Biblioteka pomocy dla skryptow
;

/eval /set _pomoc_dir=%{TFDIR}/pomoc
/eval /set _pomoc_def_dir=%{_pomoc_dir}/def
/eval /set _pomoc_alias_dir=%{_pomoc_dir}/alias

/def pomoc = \
    /let _arg=%{*} %; \
    /let _help_def=0 %; \
    /if (_arg =~ NULL) \
	/mesg Musisz podac dzial pomocy %; \
	/mesg Np. /pomoc /druzyna %; \
	/return %; \
    /endif %; \
    /if (substr(_arg, 0, 1) =~ "/") \
	/let _help_def=1%; \
        /let _arg=$[substr(_arg, 1)] %; \
    /endif %; \
    /if (_help_def) \
	/let _help_file=$[strcat(_pomoc_def_dir, '/', _arg)] %; \
    /else \
        /let _help_file=$[strcat(_pomoc_alias_dir, '/', _arg)] %; \
    /endif %; \
    /quote -S /_help_quote '%_help_file
    
/def _help_quote = \
    /test echo("%{*}")