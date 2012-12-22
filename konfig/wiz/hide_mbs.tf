; wkurzaja mnie te wszystkie smieszne chore texty jak wpisuje mbs
; gaguje kazdy z tych textow i wyswietla poprostu 'brak wiadomosci'
; !
; Rindarin, 07/05/06

/set mbs_on=0

/def mbs = \
    /send mbs%;\
    /set mbs_on=1

/def -Fp5 -E(mbs_on) -ag -mregexp -t'((Oscar|Madej|Alvin|Silvathraec|Kuti) logged in|W swoim umysle slyszysz glos Jezdzca Apokalipsy|RULE|HINT|Good news: NO news|Luchshaya novost|You have been demoted to apprentice \(1\)|Hadashot tovot she-ein hadashot|Inga nyheter|(Loudernn|Aenyeth) tells you|Onsen suki desu ka|This space for hire|Oh wow! No new articles|Oops! We seem to have run out of articles for you|This message was examined by Inspector No|Do something unusual today\. Write some code|Sorry, but your lucky message has been removed|This is a beta version of this article|This is your article|This is unbelievable! No news to be found|No new news yet! If you have nothing else to do, you can write some yourself|Sorry, no news! Write some yourself so that others can be happy|WHAT HAVE YOU DONE\?\?\? All the news is DELETED|Since you haven|Argh! Dropped all the news into the sewer|And so it was said:|The Newsboards are all stubborn today|##|Relax, take a beer, put your feet up: No news today|Sorry, your favourite passtime is exhausted|No news is good news!)' _hide_mbs = \
    /pecho MBS: Brak nowych wiadomosci. %;\
    /set mbs_on=0
