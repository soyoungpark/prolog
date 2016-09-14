% CIS 554 HW 0-1 : Root Seller
% Student Name: SoYoung Park
% PennID: 18135937
patient(katricia).
patient(morien).
patient(saradin).
patient(uther).

location(emerald_meadow).
location(haghaven).
location(kings_woods).
location(northern_cliffs).

herb(bruiseleaf).
herb(silverweed).
herb(thornbloom).
herb(wildroot).

affliction(abyss_fever).
affliction(patchfoot).
affliction(sandspots).
affliction(white_chills).

solve :-
	location(KatriciaLocation), location(MorienLocation), location(SaradinLocation), location(UtherLocation),
	all_different([KatriciaLocation, MorienLocation, SaradinLocation, UtherLocation]),

	herb(KatriciaHerb), herb(MorienHerb), herb(SaradinHerb), herb(UtherHerb),
	all_different([KatriciaHerb, MorienHerb, SaradinHerb, UtherHerb]),

	affliction(KatriciaAffliction), affliction(MorienAffliction), affliction(SaradinAffliction), affliction(UtherAffliction),
	all_different([KatriciaAffliction, MorienAffliction, SaradinAffliction, UtherAffliction]),

	% patient | location | herb | affliction
	Quadruples = [ [katricia, KatriciaLocation, KatriciaHerb, KatriciaAffliction],
				   [morien, MorienLocation, MorienHerb, MorienAffliction],
				   [saradin, SaradinLocation, SaradinHerb, SaradinAffliction],
				   [uther, UtherLocation, UtherHerb, UtherAffliction] ], 

	% 1. The herb used to treat Katricia's illness (which isn't bruiseleaf) can be found only in Emerald Meadow.
	\+ member([katricia, _, bruiseleaf, _], Quadruples),
	member([katricia, emerald_meadow, _, _], Quadruples),

	% 2. The herb used to cure Saradin's affliction isn't the one found only in King's Woods. Morien's illness was easily treated with some silverweed. 
	\+ member([saradin, kings_woods, _, _], Quadruples),
	member([morien, _, silverweed, _], Quadruples),

	% 3. Uther was diagnosed with patchfoot(which was cured by some crushed wildroot). 
	% The herb used to treat sandspots isn't bruiseleaf.
	member([uther, _, wildroot, patchfoot], Quadruples),
	\+ member([_, _, bruiseleaf, sandspots], Quadruples),
	

	% 4. The herb found only in Haghaven Swamp (which isn't bruiseleaf) is used to cure the white chills. 
	\+ member([_, haghaven, bruiseleaf, _], Quadruples),
	member([_, haghaven, _, white_chills], Quadruples),

	tell(katricia, KatriciaLocation, KatriciaHerb, KatriciaAffliction),
	tell(morien, MorienLocation, MorienHerb, MorienAffliction),
	tell(saradin, SaradinLocation, SaradinHerb, SaradinAffliction),
	tell(uther, UtherLocation, UtherHerb, UtherAffliction).

% Succeeds if all elements of the argument list are bound and different.
% Fails if any elements are unbound or equal to some other element.
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(P,L,X,A) :-
	write('Patient '), write(P), write(' afflicted with '), write(A), write(' was given '), write(X), write(' from '), write(L), write('.'), nl.  


