%casal(pessoa,pessoa)
casal('Ana','Bruno').
casal('António','Barbara').
%gosta(pessoa,alimento)
gosta('Ana',peru).
gosta('Ana',frango).
gosta('Ana',salmao).
gosta('Ana',vinho_verde).
gosta('Bruno',peru).
gosta('Bruno',salmao).
gosta('Bruno',solha).
gosta('Bruno',cerveja).
gosta('Bruno',vinho_verde).
gosta('Bruno',vinho_maduro).
%combina(comida,bebida)
combina(peru,vinho_maduro).
combina(frango,vinho_maduro).
combina(salmao,vinho_verde).
combina(solha,vinho_verde).

/*A*/
casal_vinho_verde(Pessoa1,Pessoa2):- (casal(Pessoa1,Pessoa2);casal(Pessoa2,Pessoa1)),
                                     gosta(Pessoa1,vinho_verde),gosta(Pessoa2,vinho_verde).
/*B*/
combina_salmao(Bebida) :- combina(salmao,Bebida).
/*C*/
combina_vinho_verde(Comida):- combina(Comida,vinho_verde).