%métodos dinâmicos para possibilitar alterar os conteúdo da posição.
:- dynamic ([
              pos_ag/3,
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
mover(X,Y,C) :-
    olhar_direita(X,Y,C);
    olhar_baixo(X,Y,C);
    olhar_cima(X,Y,C);
    olhar_esquerda(X,Y,C).
    %\+ membro([X,Y], lista_caminho).

%olha e vai para cima se for livre
olhar_cima(X,Y,C) :-
    Y1 is Y + 1,
    livre(X, Y1),
    imprime(X,Y1),
    Cn is C + 1,
    atualiza_pos_ag(X, Y1, Cn).

%olhar e vai pra baixo se for livre
olhar_baixo(X,Y,C) :-
    Y1 is Y -1,
    livre(X, Y1),
    imprime(X,Y1),
    Cn is C + 1,
    atualiza_pos_ag(X, Y1, Cn).

%olha e vai para direita se for livre
olhar_direita(X,Y,C) :-
    X1 is X + 1,
    livre(X1, Y),
    imprime(X1,Y),
    Cn is C + 1,
    atualiza_pos_ag(X1, Y, Cn).

%olha e vai para esquerda se for livre
olhar_esquerda(X,Y,C) :-
    X1 is X - 1,
    livre(X1, Y),
    imprime(X1,Y),
    Cn is C + 1,
    atualiza_pos_ag(X1, Y, Cn).

iniciar(X, Y, Xo, Yo) :-
    assert(pos_ag(X, Y, 1)),
	caminhar(Xo, Yo, []), nl, write('Fim...').

%age recursivamente chamando o mover que olha e move se possível
caminhar(Xo, Yo, Conhecidos) :-
    pos_ag(X, Y, C),
    X=Xo, Y=Yo -> atualiza_pos_ag(1,3,0),
    nl, write('Cheguei! '), nl,
    write(Conhecidos),
    !.
caminhar(Xo, Yo, Conhecidos) :-
    pos_ag(X, Y, C),
    mover(X,Y,C),
    caminhar(Xo, Yo, [pos_ag(X, Y, C)|Conhecidos]).

%atualiza a posição atual do meu agente
atualiza_pos_ag(X, Y, C) :-
    retract(pos_ag(_, _, _)),
    assert(pos_ag(X, Y, C)).

%predicado de impressão
imprime(X,Y) :-
    write('Vou para: ['), write(X), write(','), write(Y), write(']'), nl.

%concatena L1 e L2, gerando L3
conc([], L, L).
conc([X | L1], L2, [X | L3]) :-
	conc(L1, L2, L3).

%não utilizando ainda
adiciona_lista(X, [X|Conhecidos]):-
    retract(lista_caminho(_)),
    assert(lista_caminho(Conhecidos)).

%verifica se X é membro da lista passada.
membro(X, [X | _]).
membro(X, [_ | C]) :-
	membro(X, C).


inverter([X | Y], Z) :-
  inverter(Y, Y1),
  conc(Y1, [X], Z).
