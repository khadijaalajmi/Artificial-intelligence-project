/* Assert a dynamic predicate for identified_brand */
:- dynamic identified_brand/1.

/* Critical questions that identify the brand directly */
critical_question :-
    verify("Was it founded by Selena Gomez"),
    (yes("Was it founded by Selena Gomez") ->
        assert(identified_brand(rare_beauty)), ! ; true).

critical_question :-
    verify("Was it founded by Charlotte Tilbury"),
    (yes("Was it founded by Charlotte Tilbury") ->
        assert(identified_brand(charlotte_tilbury)), ! ; true).

critical_question :-
    verify("Was it founded by Rihanna"),
    (yes("Was it founded by Rihanna") ->
        assert(identified_brand(fenty_beauty)), ! ; true).

critical_question :-
    verify("Was it founded by Jerrod Blandino and Jeremy Johnson"),
    (yes("Was it founded by Jerrod Blandino and Jeremy Johnson") ->
        assert(identified_brand(too_faced)), ! ; true).

/* The go predicate */
go :-
    writeln("Welcome to 'Guess the Makeup Brand💄' game! "),
    (critical_question; true),  /* Call critical_question but proceed if it fails */
    hypothesize(Person),
    write("I guess that the makeup brand is: "),
    write(Person),
    write("🧐"),
    nl,
    undo.

/* Modify hypothesize to check for identified_brand */
hypothesize(Brand) :- identified_brand(Brand), !.
hypothesize(Brand) :- rare_beauty, !, Brand = rare_beauty.
hypothesize(Brand) :- charlotte_tilbury, !, Brand = charlotte_tilbury.
hypothesize(Brand) :- fenty_beauty, !, Brand = fenty_beauty.
hypothesize(Brand) :- too_faced, !, Brand = too_faced.
hypothesize(unknown) :-
    write("The makeup brand is unknown based on the given answers."), !.

/* Brand identification rules */
rare_beauty :-
    verify("Is the owner of the brand a singer"),
    verify("Is the brand known for its blushes"),
    verify("Is the brand inspired by a studio album"),
    verify("Does the brand aim to break down unrealistic standards of perfection").

charlotte_tilbury :-
    verify("Is the brand a luxury makeup brand"),
    verify("Is the brand known for its flawless filter"),
    verify("Was the brand founded by a British makeup artist who holds the title of chair"),
    verify("Does it have a store in Saudi Arabia").

fenty_beauty :-
    verify("Is the brand known for its lipsticks"),
    verify("Has the brand collaborated with MAC Cosmetics"),
    verify("Was the brand launched in 2017"),
    verify("Does the brand offer 50 shades of concealer").

too_faced :-
    verify("Is the brand known for its Born This Way Foundation"),
    verify("Is the brand affiliated with The Estée Lauder Companies"),
    verify("Is the brand known for its playful and innovative approach to makeup"),
    verify("Was the brand created by two friends who share a love for makeup").

/* How to ask questions */
ask(Question) :-
    write("Does the brand have the following attribute: "),
    write(Question),
    write("? (yes/no) "),
    read(Response),
    nl,
    ( (Response == yes ; Response == y)
    ->
    assert(yes(Question)) ;
    assert(no(Question)), fail).

:- dynamic yes/1,no/1.

/* How to verify something */
verify(S) :-
    (yes(S)
    ->
    true ;
    (no(S)
    ->
    fail ;
    ask(S))).

/* Add undo rule for identified_brand */
undo :- retract(identified_brand(_)), fail.
undo :- retract(yes(_)), fail.
undo :- retract(no(_)), fail.
undo.