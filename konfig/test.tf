/def -Fp5 -mregexp -t'Wykrzywiasz twarz w grymasie nienawisci (.*) trafiasz (.*) w (.*) (ledwo muskajac|(?<!lekko |powaznie |bardzo ciezko )raniac|lekko raniac|powaznie raniac|bardzo ciezko raniac|masakrujac)' mc_spec_twoj = \
    /echo 0: %{P0} %; \
    /echo 1: %{P1} %; \
    /echo 2: %{P2} %; \
    /echo 3: %{P3} %; \
    /echo 4: %{P4} %; \
    /echo 5: %{P5} %; \
    /echo 6: %{P6} %; \
    /echo 7: %{P7} %; \
    /echo 8: %{P8} %; \
    /echo 9: %{P9} %; \
    /echo 10: %{P10} 
