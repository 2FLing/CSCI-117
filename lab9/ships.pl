% Render the ship term as a nice table.
:- use_rendering(table,
		 [header(s('Ship', 'Leaves at', 'Carries', 'Chimney', 'Goes to'))]).

% Each ship is represented a term, s(S,L,Ca,Ch,G). A list of 5 such terms is a solution.
goes_PortSaid(Goes) :-
	ships(S),
	member(s(Goes,_,_,_,portSaid), S).

carries_tea(Carries) :-
	ships(S),
	member(s(Carries,_,tea,_,_), S).

ships(S) :- 
  length(S,5),
   % Rules 1 - 15
  member(s(greek,six,coffee,_,_),S), % 1
  S = [_,_,s(_,_,_,black,_),_,_],    % 2
  member(s(english,nine,_,_,_),S), % 3
  left(s(french,_,_,blue,_),s(_,_,coffee,_,_),S), % 4
  left(s(_,_,cocoa,_,_),s(_,_,_,_,marseille),S), % 5
  member(s(brazilian,_,_,_,manila),S), % 6
  next(s(_,_,rice,_,_),s(_,_,_,green,_),S), % 7
  member(s(_,five,_,_,genoa),S), % 8
  left(s(_,_,_,_,marseille),s(spanish,seven,_,_,_),S), % 9
  member(s(_,_,_,red,hamburg),S), % 10
  next(s(_,seven,_,_,_),s(_,_,_,white,_),S), % 11
  border(s(_,_,corn,_,_),S), % 12
  member(s(_,eight,_,black,_),S), % 13
  next(s(_,_,corn,_,_),s(_,_,rice,_,_),S),  % 14  
  member(s(_,six,_,_,hamburg),S),   % 15
  member(s(_,_,_,_,portSaid),S),   % forces some ship to go to Port Said
  member(s(_,_,tea,_,_),S).        % forces some ship to carry tea

% Predicates for capturing relationships in a list of ships, Ls
next(A, B, Ls) :- append(_,[A,B|_],Ls).  % A and B are next to one another
next(A, B, Ls) :- append(_,[B,A|_],Ls).
left(A, B, Ls) :- append(_,[A,B|_],Ls).  % A is to the left of B (and thus B is to the right of A)
border(A, Ls) :- append(_,[A|_],Ls).   % A is on the border
border(A, Ls) :- append(_,[_|A],Ls).
