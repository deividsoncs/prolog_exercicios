%Exceício do livro Prolog (PALAZZO)
%defino os fatos sobre o gênero
masculino(joão).
masculino(jorge).
masculino(josé).
feminino(maria).
feminino(íris).
feminino(ana).
feminino(júlia).

%defino os fatos para os progenitores
progenitor(maria, josé).
progenitor(joão, josé).
progenitor(joão, ana).
progenitor(josé, júlia).
progenitor(josé, íris).
progenitor(íris, jorge).

%regra de X diferente de Y
diferente(X, Y) :-
    X\==Y.

%regra de quem é filho
filho(X, Y) :-
    progenitor(Y, X).

%regra de quem é irmã
irma(X, Y) :-
    progenitor(Z, X),
    progenitor(Z, Y),
    feminino(X),
    diferente(X, Y).

%regra de quem é irmão
irmao(X, Y) :-
    progenitor(Z, X),
    progenitor(Z, Y),
    masculino(X),
    diferente(X, Y).

%regra recursiva que me da o antepassado em qualquer nível de profundidade.
antepassado(X, Z) :-
    progenitor(X, Z).
antepassado(X, Z) :-
    progenitor(X, Y),
    antepassado(Y, Z).

% X tio de Y
tio(X, Y) :-
    filho(X,Z), %Z é pai ou mãe de X
    progenitor(W, Y), %W é o pai ou mãe do sobrino(a)
    progenitor(Z, W),
    masculino(X).

% X tia de Y
tia(X, Y) :-
    filho(X,Z), %Z é pai ou mãe de X
    progenitor(W, Y), %W é o pai ou mãe do sobrino(a)
    progenitor(Z, W),
    irma(X, W).

%regra recursiva checa se X é descendente de Y
descendente(X,Y):-
    filho(X,Y).
descendente(X,Y):-
    filho(X,Z),
    descendente(Z,Y).
