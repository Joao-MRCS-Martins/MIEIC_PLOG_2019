:- use_module(library(clpfd)).

car_line :-
  Cars = [AM,VE,AZ,PR],
  Size = [S1,S2,S3,S4],
  domain(Cars,1,4),
  domain(Size,1,4),
  all_distinct(Cars),
  all_distinct(Size),
  C1 #= AZ -1, C2 #= AZ + 1,
  element(I1, Cars, C1),element(I2,Cars,C2),
  element(I1,Size,Sx),element(I2,Size,Sy),
  Sx #< Sy,
  S2 #< S1, S2 #< S3, S2 #<S4,
  VE #> AZ, AM #>PR,
  append(Cars,Size,Vars),  
  labeling([],Vars),write(Cars).
  