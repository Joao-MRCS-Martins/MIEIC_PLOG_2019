%livro(nome)
livro('Os Maias').
%nacionalidade(pessoa,nacionalidade)
nacionalidade('Eça de Queiroz','português').
%escreveu(autor,obra)
escreveu('Eça de Queiroz','Os Maias'). /*A*/
%autor(Pessoa)
autor(Autor):- escreveu(Autor,_).
%tipo(obra,tipo)
tipo('Os Maias','romance').
tipo('Os Maias','ficção').
/*B*/
romancista_portugues(Autor):- nacionalidade(Autor,'português'),
                              escreveu(Autor,Livro),
                              tipo(Livro,'romance').
/*C*/
ficcionista_variado(Autor):- escreveu(Autor,LivroFic),
                             tipo(Livro,'ficção'),
                             escreveu(Autor,LivroOut),
                             tipo(LivroOut,Tipo),
                             Tipo \= 'ficção'.