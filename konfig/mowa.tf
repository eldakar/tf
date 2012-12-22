/def -aBCyellow -p100 -mregexp -t'[Pp]yta( sie ciebie|sz .*) o'   _mowi_pyta

/def -p100 -mregexp -t'krzyczy'        _mowi_krzyczy    = \
    /echo %; \
    /substitute -p @{BCcyan}*@{nBCyellow}K@{nBCcyan}* @{nuBCwhite}%{PL}krzyczy@{nBCcyan}%{PR}@{n} %; \
    /repeat -0 1 /echo
    
/def -p110 -mregexp -t'^Krzyczysz'     _mowi_krzyczy_ja = /substitute -p @{BCcyan}*@{nBCyellow}K@{nBCcyan}* @{nBCred}%{PL}@{nBCred}Krzyczysz%{PR}
/def -p100 -mregexp -t'Szepczesz'      _mowi_szepcze_ja = /substitute -p @{BCcyan}*@{nBCyellow}S@{nBCcyan}* @{nBCwhite}%{PL}Szepczesz%{PR}@{n}
/def -p150 -mregexp -t'(?-i)Mowisz'    _mowi_mowi_ja    = /substitute -p @{BCcyan}*@{nBCyellow}M@{nBCcyan}* @{n}%{PL}%{P1}@{BCgreen}Mowisz@{nBCwhite}%{PR}


/def -Fp300 -mregexp -t'szepcze do ciebie:' _mowi_szepcze  = /substitute -p @{BCcyan}*@{nBxCyellow}S@{nBCcyan}* @{nBxCwhite}%{PL}@{nCmagenta}szepcze do ciebie:@{nBxCwhite}%{PR}
/def -p100 -mregexp -t'belkocze pijacko:'   _mowi_belkocze = /substitute -p @{BCcyan}*@{nBCred}B@{nBCcyan}* @{nBCwhite}%{PL}@{nBCyellow}belkocze pijacko:@{nBCwhite}%{PR}

/def -p150 -mregexp -t' ((?-i)mowi|skrzypi|dudni|mruczy|nuci|marudzi|brzeczy|zawodzi|piszczy|jeczy|skrzeczy|zgrzyta|spiewa|warczy|burczy|syczy|grzmi|belkocze pijacko|huczy|mamrocze)((.*)| )do ciebie:' _mowi_mowi_do_mnie = \
    /substitute -p @{BCcyan}*@{nBCyellow}M@{nBCcyan}* @{nBCwhite}%{PL}@{nBCmagenta}%{P0}@{nBCwhite}%{PR}

/def -p100 -mregexp -t' ((?-i)mowi|skrzypi|dudni|mruczy|nuci|marudzi|brzeczy|zawodzi|piszczy|jeczy|skrzeczy|zgrzyta|spiewa|warczy|burczy|syczy|grzmi|belkocze pijacko|huczy|mamrocze)(| z (.*)|(.*)|( z (.*) do (?!ciebie))|(.*) do (?!ciebie)):' _mowi_mowi_nie_do_mnie = \
    /substitute -p @{BCcyan}*@{nBCyellow}M@{nBCcyan}* @{nBCwhite}%{PL}@{nCgreen}%{P0}@{nBCwhite}%{PR}
 
/def -p200 -mregexp -t'mowi w Mrocznej Mowie:' _mowi_Mroczna = \
	/substitute -p @{BCcyan}*@{nBCred}MC@{nBCcyan}*@{nBCwhite} %{PL}@{nCgreen}%{P0}@{nBCwhite}%{PR}
    
/def -p250 -mregexp -t'mowi do ciebie w Mrocznej Mowie:' _mowi_Mroczna_do_mnie = \
	/substitute -p @{BCcyan}*@{nBCred}MC@{nBCcyan}*@{nBCwhite} %{PL}@{nBCmagenta}%{P0}@{nBCwhite}%{PR}
	
; Dalej niewazne :P

