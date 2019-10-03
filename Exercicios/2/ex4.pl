fatorial(1,1).
fatorial(N,V):- N>1,N1 is N-1,fatorial(N1,V1), V is (N * V1).

fibonacci(0,1).
fibonacci(1,1).
fibonacci(N,V):- N>1, N1 is N-1, N2 is N-2,fibonacci(N1,V1),fibonacci(N2,V2),V is V1+V2.