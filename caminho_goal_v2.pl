%métodos dinâmicos para possibilitar alterar os conteúdo da posição.
:- dynamic ([
              pos_ag/2,
              lista_caminho/1
            ]).
%obstáculos
bloco(X, Y) :- X=3, Y=3.
bloco(X, Y) :- X=4, Y=2.
bloco(X, Y) :- X=6, Y=1.
bloco(X, Y) :- X=7, Y=4.

%para não estourar o tabuleiro, defino o tamanho do tabuleiro
bloco(X,_) :- X < 1; X > 8.
bloco(_,Y) :- Y < 1; Y > 4.

%passagem livre
livre(X, Y) :- \+bloco(X, Y).

%lista_caminho([pos_ag(X,Y)|L]).

%verifica se a posição pode ser ocupada e ocupa
mover(X,Y) :-
    olhar_direita(X,Y);
    olhar_baixo(X,Y);
    olhar_cima(X,Y);
    olhar_esquerda(X,Y).
    %\+ membro([X,Y], lista_caminho).

%olha e vai para cima se for livre
olhar_cima(X,Y) :-
    Y1 is Y + 1,
    livre(X, Y1),
    imprime(X,Y1), nl,
    atualiza_pos_ag(X, Y1).

%olhar e vai pra baixo se for livre
olhar_baixo(X,Y) :-
    Y1 is Y -1,
    livre(X, Y1),
    imprime(X,Y1),
    atualiza_pos_ag(X, Y1).

%olha e vai para direita se for livre
olhar_direita(X,Y) :-
    X1 is X + 1,
    livre(X1, Y),
    imprime(X1,Y),
    atualiza_pos_ag(X1, Y).

%olha e vai para esquerda se for livre
olhar_esquerda(X,Y) :-
    X1 is X - 1,
    livre(X1, Y),
    imprime(X1,Y),
    atualiza_pos_ag(X1, Y).

iniciar(X, Y, Xo, Yo) :-
    assert(pos_ag(X, Y)),
	caminhar(Xo, Yo), nl, write('Fim...').

%age recursivamente chamando o mover que olha e move se possível
caminhar(Xo, Yo) :-
    pos_ag(X, Y),
    X=Xo, Y=Yo, nl, write('Cheguei!').
caminhar(Xo, Yo) :-
    pos_ag(X, Y),
    mover(X,Y),
    caminhar(Xo, Yo).

%atualiza a posição atual do meu agente
atualiza_pos_ag(X, Y) :-
    retract(pos_ag(_,_)),
    assert(pos_ag(X,Y)).

%predicado de impressão
imprime(X,Y) :-
    write('Vou para: ['), write(X), write(','), write(Y), write(']'), nl.
