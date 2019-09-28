homem('João').
mulher('Maria').
mulher('Ana').
animal(cao).
animal(gato).
animal(tigre).
jogo(xadrez).
jogo(damas).
desporto(tenis).
desporto(natacao).
mora_em('João',apartamento).
mora_em('Ana',apartamento).
mora_em('Maria',casa).
gosta_de('João',cao).
gosta_de('João',gato).
gosta_de('João',tenis).
gosta_de('João',natacao).
gosta_de('Ana',cao).
gosta_de('Ana',tenis).
gosta_de('Ana',damas).
gosta_de('Maria',tigre).
gosta_de('Maria',tenis).
gosta_de('Maria',xadrez).

/*A*/
mora_apt_gosta_ani(Pessoa):- mora_em(Pessoa,apartamento),gosta_de(Pessoa,Ani),animal(Ani).
/*B*/
moram_casa_gostam_desp(Pessoa1,Pessoa2):- mora_em(Pessoa1,casa),
                                          mora_em(Pessoa2,casa),
                                          gosta_de(Pessoa1,Desp1),
                                          desporto(Desp1),
                                          gosta_de(Pessoa2,Desp2),
                                          desporto(Desp2).
/*C*/
gosta_jogos_desp(Pessoa):-  gosta_de(Pessoa,Jogo),
                            jogo(Jogo),
                            gosta_de(Pessoa,Desp),
                            desporto(Desp).
/*d*/
mulher_gosta_tenis_tigre(Pessoa):- mulher(Pessoa),gosta_de(Pessoa,tenis),gosta_de(Pessoa,tigre).
