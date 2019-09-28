%aluno(nome,cadeira)
aluno(joao, paradigmas).
aluno(maria, paradigmas).
aluno(joel, lab2).
aluno(joel, estruturas).
%frequenta(aluno,instituicao)
frequenta(joao, feup).
frequenta(maria, feup).
frequenta(joel, ist).
%professor(nome,cadeira)
professor(carlos, paradigmas).
professor(ana_paula, estruturas).
professor(pedro, lab2).
%funcionario(docente,instituicao)
funcionario(pedro, ist).
funcionario(ana_paula, feup).
funcionario(carlos, feup).


/*A*/
aluno_prof(Aluno,Prof):- aluno(Aluno,Cadeira), professor(Prof,Cadeira).

/*B*/
pessoal_uni(Pessoa,Universidade):- frequenta(Pessoa,Universidade) ; funcionario(Pessoa,Universidade).

/*C*/
colega(Pessoa1,Pessoa2):- 
    (aluno(Pessoa1,Cadeira),aluno(Pessoa2,Cadeira), Pessoa1 @< Pessoa2);
    (frequenta(Pessoa1,Uni),frequenta(Pessoa2,Uni), Pessoa1 @< Pessoa2);
    (funcionario(Pessoa1,Univ),funcionario(Pessoa2,Univ)), Pessoa1 @< Pessoa2.