% pex5.pl
% USAFA UFO Sightings 2024
%
% name: Sabrina McGarvey
%
% Documentation: I discussed my code with C2C Tanner Woodring, he pointed out that I had not capitilized some of my variables when I switched 
% to organizing by day of the week.

day(tuesday).
day(wednesday).
day(thursday).
day(friday).

cadet(smith).
cadet(garcia).
cadet(chen).
cadet(jones).

fly(ufo).
fly(weatherBalloon).
fly(kite).
fly(fighter).
fly(cloud).

solve :-
    cadet(TueCadet), cadet(WedCadet), cadet(ThuCadet), cadet(FriCadet),
    all_different([TueCadet, WedCadet, ThuCadet, FriCadet]),
    
    fly(TueFly), fly(WedFly), fly(ThuFly), fly(FriFly),
    all_different([TueFly, WedFly, ThuFly, FriFly]),
    
    Triples = [ [TueCadet, TueFly, tuesday],
                [WedCadet, WedFly, wednesday],
                [ThuCadet, ThuFly, thursday],
                [FriCadet, FriFly, friday] ],
    
    % C4C Smith did not see a weather balloon, nor kite.
    \+ member([smith, weatherBalloon, _], Triples),
    \+ member([smith, kite, _], Triples),
    
    % The one who saw the kite isn’t C4C Garcia.
    \+ member([garcia, kite, _], Triples),
    
    % Friday’s sighting was made by either C4C Chen or the one who saw the fighter aircraft.
    ( member([chen, _, friday], Triples); member([_, fighter, friday], Triples)),
    
    % The kite was not sighted on Tuesday.
    \+ member([_, kite, tuesday], Triples),
              
    % Neither C4C Garcia nor C4C Jones saw the weather balloon.
    \+ member([garcia, weatherBalloon, _], Triples),
    \+ member([jones, weatherBalloon, _], Triples),
    
    % C4C Jones did not make their sighting on Tuesday.
    \+ member([jones, _, tuesday], Triples),

    % C4C Smith saw an object that turned out to be a cloud.
    member([smith, cloud, _], Triples),
    
    % The fighter aircraft was spotted on Friday.
    member([_, fighter, friday], Triples),
    
    % The weather balloon was not spotted on Wednesday.
    \+ member([_, weatherBalloon, wednesday], Triples),
    
    tell(TueCadet, TueFly, tuesday),
    tell(WedCadet, WedFly, wednesday),
    tell(ThuCadet, ThuFly, thursday),
    tell(FriCadet, FriFly, friday).
    
% Succeeds if all elements of the argument list are bound and different.
% Fails if any elements are unbound or equal to some other element.
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).
    
tell(X, Y, Z) :-
    write('C4C '), write(X), write(' saw the '), write(Y), write(' on '), write(Z), write('.'), nl.
% The query to get the answer(s) or that there is no answer
% ?- solve.
