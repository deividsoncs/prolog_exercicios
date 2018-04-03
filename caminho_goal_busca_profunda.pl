%Árvore do tabuleiro.
liga(a1, a2).
liga(a1, b1).

liga(a2, a1).
liga(a2, a3).
liga(a2, b2).

liga(a3, a2).
liga(a3, a4).
%liga(a3, b3). podado

liga(a4, a3).
liga(a4, a4).
liga(a4, b4).

liga(a5, a4).
liga(a5, a6).
liga(a5, b5).

liga(a6, a5).
%liga(a6, a7). podado
%liga(a6, b6). podado

%liga(a8, a7). podado
liga(a8, b8).

liga(b1, a1).
liga(b1, b2).
liga(b1, c1).

liga(b2, a2).
%liga(b2, b3). podado
liga(b2, c2).
liga(b2, b1).

liga(b4, a4).
liga(b4, b5).
%liga(b4, c4). podado
%liga(b4, b3). podado

liga(b5, a5).
%liga(b5, b6).
liga(b5, c5).
liga(b5, b4).

%liga(b7, a7). podado
liga(b7, b8).
liga(b7, c7).
%liga(b7, b6). podado

liga(b8, a8).
liga(b8, c8).
liga(b8, b7).

liga(c1, b1).
liga(c1, c2).
liga(c1, d1).

liga(c2, b2).
liga(c2, c3).
liga(c2, d2).
liga(c2, c1).

%liga(c3, b3). podado
%liga(c3, c4).
liga(c3, d3).
liga(c3, c2).

liga(c5, b5).
liga(c5, c6).
liga(c5, d5).
%liga(c5, c4). podado

%liga(c6, b6).
liga(c6, c7).
%liga(c6, d6).
liga(c6, c5).

liga(c7, b7).
liga(c7, c8).
liga(c7, d7).
liga(c7, c6).

liga(c8, b8).
liga(c8, d8).
liga(c8, c7).

liga(d1, c1).
liga(d1, d2).

liga(d2, c2).
liga(d2, d3).
liga(d2, d1).

liga(d3, c3).
liga(d3, d4).
liga(d3, d2).

%liga(d4, c4). podado
liga(d4, d5).
liga(d4, d3).

liga(d5, c5).
%liga(d5 d6). podado
liga(d5, d4).

liga(d7, c5).
liga(d7, d8).
%liga(d7 d6). podado

liga(d8, c8).
liga(d8, d7).
%busca na árvore
busca(N, N, _).
busca(PosAtual, Objetivo, Conhecidos) :-
    liga(PosAtual, X),
    \+(member(X, Conhecidos)),
    write('-'),
    write(PosAtual),
	busca(X, Objetivo, [X|Conhecidos]).
