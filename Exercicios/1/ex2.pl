pilot('Lamb').
pilot('Besenyei').
pilot('Chambliss').
pilot('MacLean').
pilot('Mangold').
pilot('Jones').
pilot('Bonhomme').
/* team(name,pilot)*/
team('Breitling','Lamb').
team('Red Bull', 'Besenyei').
team('Red Bull', 'Chambliss').
team('Mediterranean Racing Team','MacLean').
team('Cobra','Mangold').
team('Matador','Jones').
team('Matador','Bonhomme').
/* plane(pilot,model)*/
plane('Lamb','MX2').
plane('Besenyei','Edge540').
plane('Chambliss','Edge540').
plane('MacLean','Edge540').
plane('Mangold','Edge540').
plane('Jones','Edge540').
plane('Bonhomme','Edge540').
circuit('Istanbul').
circuit('Budapest').
circuit('Porto').

/*winner(circuit,pilot)*/
winner('Porto','Jones').
winner('Budapest','Mangold').
winner('Istanbul','Mangold').
/*gates(circuit,number)*/
gates('Istanbul', 9).
gates('Budapest', 6).
gates('Porto', 5).

team_wins(Team,Circuit):- team(Team,Pilot), winner(Circuit,Pilot).

/*A*/
%winner('Porto',Pilot).
/*B*/
%team_wins(Team,'Porto').
/*C*/
more_than_one_win(Pilot):- winner(Circuit1,Pilot),winner(Circuit2,Pilot),Circuit1 \= Circuit2. 
/*D*/
more_than_8_gates(Circuit):- gates(Circuit,N), N>8.
/*E*/
pilot_not_fly_Edge(Pilot):- plane(Pilot,Model), Model \= 'Edge540'.
