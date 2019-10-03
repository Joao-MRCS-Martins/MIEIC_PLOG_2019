e_primo(2).
e_primo(3).
e_primo(N):- N>3,\+verifica_div(N,2).

verifica_div(N,P):- P =< sqrt(N),divisivel_por(N,P).
verifica_div(N,P):- P1 is P+1, P1 =< sqrt(N),verifica_div(N,P1).
divisivel_por(N,P) :- N mod P =:= 0.