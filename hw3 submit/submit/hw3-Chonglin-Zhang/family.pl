% males
male(charles).
male(princewilliam).
male(princeharry).
male(princegeorge).
male(princelouis).
male(archieharrison).

% females
female(camilla).
female(diana).
female(catherine).
female(meghan).
female(princesscharlotte).

% spouse relationships (include both current and divorced)
spouse(charles, camilla).
spouse(camilla, charles).
spouse(charles, diana). % divorced
spouse(diana, charles). % divorced
spouse(princewilliam, catherine).
spouse(catherine, princewilliam).
spouse(princeharry, meghan).
spouse(meghan, princeharry).

% mother relationships (based on the provided family tree)
mother(catherine, princegeorge).
mother(catherine, princesscharlotte).
mother(catherine, princelouis).
mother(diana, princewilliam).
mother(diana, princeharry).
mother(meghan, archieharrison).

% father relationships (based on the provided family tree)
father(charles, princewilliam).
father(charles, princeharry).
father(princewilliam, princegeorge).
father(princewilliam, princesscharlotte).
father(princewilliam, princelouis).
father(princeharry, archieharrison).

% brother(X,Y) - X is the brother of Y
brother(X, Y) :- male(X), sibling(X, Y), X \== Y.

% sister(X,Y) - X is the sister of Y
sister(X, Y) :- female(X), sibling(X, Y), X \== Y.

% sibling(X,Y) - X is a sibling of Y
sibling(X, Y) :- mother(M, X), mother(M, Y), father(F, X), father(F, Y), X \== Y.

% nephew(X,Y) - X is a nephew of Y
nephew(X, Y) :- male(X), (mother(M, X), sibling(M, Y) ; father(F, X), sibling(F, Y)).

% niece(X,Y) - X is a niece of Y
niece(X, Y) :- female(X), (mother(M, X), sibling(M, Y) ; father(F, X), sibling(F, Y)).

% grandparent(X,Y) - X is a grandparent of Y
grandparent(X, Y) :- mother(X, Z), (mother(Z, Y) ; father(Z, Y)).
grandparent(X, Y) :- father(X, Z), (mother(Z, Y) ; father(Z, Y)).

% stepmother(X,Y) - X is the stepmother of Y
stepmother(X, Y) :- spouse(X, Z), male(Z), (mother(Z, Y) ; father(Z, Y)), \+ mother(X, Y).

% cousin(X,Y) - X is a cousin of Y
cousin(X, Y) :- (mother(M1, X), mother(M2, Y), sibling(M1, M2) ; father(F1, X), father(F2, Y), sibling(F1, F2)).

% uncle(X,Y) - X is an uncle of Y (either by being the brother of one of Y's parents or by being married to one of Y's parent's sisters)
uncle(X, Y) :-
    male(X),
    ( 
      (sibling(X, M), mother(M, Y));
      (sibling(X, F), father(F, Y));
      (spouse(X, A), sister(A, M), mother(M, Y));
      (spouse(X, A), sister(A, F), father(F, Y))
    ),
    X \== Y.

% aunt(X,Y) - X is an aunt of Y (either by being the sister of one of Y's parents or by being married to one of Y's parent's brothers)
aunt(X, Y) :-
    female(X),
    (
      (sibling(X, M), mother(M, Y));
      (sibling(X, F), father(F, Y));
      (spouse(X, U), brother(U, M), mother(M, Y));
      (spouse(X, U), brother(U, F), father(F, Y))
    ),
    X \== Y.



