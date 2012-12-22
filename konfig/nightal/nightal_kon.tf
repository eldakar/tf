;
; Plik  : nightal_kon.tf
; Autor : volus
; Data  : 01/07/2006, 22:48:35
; Opis  : 
;

/def ustaw_konia = \
    /set _kon=%{*} %; \
    /pecho Ustawiony kon: %{*}
    
/def query_kon = \
    /echo %{_kon}
    
/def dos = \
    dosiadz $(/m_dop $(/query_kon))
    
/def zaw = \
    przywiaz $(/m_bie $(/query_kon))
    
/def odw = \
    odwiaz $(/m_bie $(/query_kon))
    
/def zsi = \
    zsiadz z konia
    
/def prz = \
    /zsi %; \
    /zaw

/def zlap = \
    zlap $(/m_bie $(/query_kon)) za uzde

/def go = \
    jedz %{1} na %{2}
    
/def stop = \
    zatrzymaj sie
    
/def pozwol = \
    kzezwol na dosiadanie $(/m_dop $(/query_kon)) %{*}

/def sz = \
    szarzuj na %{*}

/def przechowaj = \
    przechowaj $(/m_bie $(/query_kon))

/def odbierz = \
    odbierz %{*-pierwszego} wierzchowca

/def osiodlaj = \
    osiodlaj $(/m_bie $(/query_kon)) siodlem

/def rozsiodlaj = \
    rozsiodlaj $(/m_bie $(/query_kon))

/ustaw_konia lekka gniada klacz

