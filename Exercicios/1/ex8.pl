%cargo(posicao,nome).
cargo(tecnico, rogerio).
cargo(tecnico, ivone).
cargo(engenheiro, daniel).
cargo(engenheiro, isabel).
cargo(engenheiro, oscar).
cargo(engenheiro, tomas).
cargo(engenheiro, ana).
cargo(supervisor, luis).
cargo(supervisor_chefe, sonia).
cargo(secretaria_exec, laura).
cargo(diretor, santiago).
%chefiado_por(empregado,chefe)
chefiado_por(tecnico, engenheiro).
chefiado_por(engenheiro, supervisor).
chefiado_por(analista, supervisor).
chefiado_por(supervisor, supervisor_chefe).
chefiado_por(supervisor_chefe, director).
chefiado_por(secretaria_exec, director).

/*A*/
% Que cargo chefia um tecnico e que cargo o chefia? FA: X: engenheiro Y: super
/*B*/
% A Ivone chefia um tecnico? FA: no
/*C*/
% Quem ocupa o cargo de supervisor? FA: luis
/*D*/
% Quem é e que cargo tem alguém chefiado por um supervisor_chefe ou um supervisor? FA: J: engenheiro P: daniel
/*E*/
% Que cargo é chefiado pelo diretor que não seja ocupado pela carolina? FA: P: supervisor_chefe