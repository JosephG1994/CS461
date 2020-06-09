% Joseph Garcia
% 5/6/2020
% CS 461

/* An expert system for animal identification. This expert system 
   identifies the species of an animal based on answering questions
   regarding the animal's classification, diet, appearance, and behavior. */
   
/* This file was tested in SWI-Prolog. */
   
/* To start the program type 	go.		in the query. */ 
 
/*	Changing the working directory to desktop in SWI-Prolog:
	
	?-	working_directory(CWD,'/users/joseph/desktop').
		CWD = 'c:/users/joseph/documents/prolog/'.
		
	Compiling the file in SWI-Prolog:
	
	?-	[hw08b].
		true.
*/
		
/*	Test for identifying the animal as a wolf:
	
	?- go.
	Does the animal: have_hair? yes.
	
	Does the animal: eat_plants_and_meat? |: no.
	
	Does the animal: eat_plants? |: no.
	
	Does the animal: eat_meat? |: yes.
	
	Does the animal: roar? |: no.
	
	Does the animal: howl? |: yes.
	
	Does the animal: live_in_packs? |: yes.
	
	Does the animal: have_rounded_ears? |: yes.
	
	The animal is a wolf
	true.
*/

/*	Test for identifying the animal as an eagle:
	
	?- go.
	Does the animal: have_hair? no.
	
	Does the animal: have_moist_skin? |: no.
	
	Does the animal: have_scales? |: no.
	
	Does the animal: have_feathers? |: yes.
	
	Does the animal: eat_meat? |: yes.
	
	Does the animal: lay_eggs? |: yes.
	
	Does the animal: not_fly? |: no.
	
	Does the animal: fly? |: yes.
	
	Does the animal: have_strong_talons? |: yes.
	
	The animal is a eagle
	true.	
*/	

/*  Test for identifying the animal as a salamander:

	?- go.
	Does the animal: have_hair? no.
	
	Does the animal: have_moist_skin? |: yes.
	
	Does the animal: eat_meat? |: yes.
	
	Does the animal: lay_eggs? |: yes.
	
	Does the animal: swim? |: yes.
	
	Does the animal: croak? |: no.
	
	Does the animal: have_a_long_tail? |: yes.
	
	The animal is a salamander
	true.
*/

/* runs the program */
go :- 
    species(Animal),
	  write('The animal is a '),
      write(Animal),
      nl,
      undo.

/* animal species to be tested */
species(bear)   	:- bear, !.
species(fox)     	:- fox, !.
species(moose)  	:- moose, !.
species(goat)		:- goat, !.
species(lion)		:- lion, !.
species(tiger)      :- tiger, !.
species(wolf)   	:- wolf, !.
species(coyote)     :- coyote, !.
species(frog)  		:- frog, !.
species(salamander) :- salamander, !.
species(alligator)  :- alligator, !.
species(snake)  	:- snake, !.
species(penguin)	:- penguin, !.
species(eagle)		:- eagle, !.
species(unknown).   /* no result (a species can't be identified) */

/* species rules */
bear		:- mammal, 
			omnivore, 
			features(roar),
			features(have_strong_limbs),
			features(hibernate).
			
fox 		:- mammal,
			omnivore,
			features(live_in_solitude),
			features(have_pointy_ears),
			features(have_a_bushy_tail).	
			
moose 		:- mammal,
			herbivore,
			features(have_hooves), 
			features(have_antlers),
			features(swim_very_well).	
			
goat 		:- mammal,
			herbivore,
			features(have_hooves), 
			features(have_horns),
			features(climb_efficiently).	
			
lion		:- mammal,
			carnivore,
			features(roar),
			features(live_in_prides),
			features(have_a_mane).
			
tiger 		:- mammal,  
			carnivore,
			features(roar),
			features(live_in_solitude),
			features(have_stripes).
			
wolf 		:- mammal, 
			carnivore,
			features(howl), 
			features(live_in_packs),
			features(have_rounded_ears).

coyote      :- mammal,
			carnivore,
			features(howl),
			feaatures(have_narrow_snouts),
			features(have_pointy_ears).
					
frog		:- amphibian,
			carnivore,
			features(lay_eggs),
			features(swim),
			features(croak).
			
salamander  :- amphibian,
			carnivore,
			features(lay_eggs),
			features(swim),
			features(have_a_long_tail).
			
alligator 	:- reptile,
			carnivore,
			features(lay_eggs),
			features(swim),
			features(have_strong_jaws).
			
snake		:- reptile,
			carnivore,
			features(lay_eggs),
			features(swim),
			features(have_no_limbs).
			
penguin		:- bird,
			carnivore,
			features(lay_eggs),
			features(not_fly),
			features(swim).
			
eagle 		:- bird, 
			carnivore,
			features(lay_eggs),
			features(fly),
			features(have_strong_talons).		

/* animal classes rules */
mammal    :- features(have_hair), !.

bird      :- features(have_feathers), !.

reptile   :- features(have_scales), !.

amphibian :- features(have_moist_skin), !.

/* animal diet rules */
carnivore :- features(eat_meat), !.

herbivore :- features(eat_plants), !.

omnivore  :- features(eat_plants_and_meat), !.


/* Questions for determining the animal features */
ask(Question) :-
    write('Does the animal: '),
    write(Question),
    write('? '),
    read(Answer),
    nl,
    ( (Answer == yes ; Answer == y)
      ->
       assert(yes(Question)) ;
       assert(no(Question)), fail).

:- dynamic yes/1,no/1.

/* Verifying the response to the questions */
features(A) :-
   (yes(A) 
    ->
    true ;
    (no(A)
     ->
     fail ;
     ask(A))).

/* Undoing all yes/no assertions */
undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail.
undo.