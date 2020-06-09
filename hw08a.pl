% Joseph Garcia
% 5/2/2020
% CS 461

/*
Sample Queries:
	
	?-	brother_of(richard, john).
	
	yes
		
This query tells me if richard and john are brothers. The query returns yes.



	?-	king(john).
	
	no
		
This query tells me if john is the king. The query returns no.
*/

% Richard is the King.
king(richard).

% Richard and John are brothers.
brother_of(richard, john).

% The Crown is on Richard's head.
on_richards_head(crown).

% Richard is a person.
person(richard).

% John is a person.
person(john).

% If you are a King, then you are a person.
person(you) :- king(you). 