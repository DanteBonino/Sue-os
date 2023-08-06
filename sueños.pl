%Punto 1
%Base de Conocimiento   
/*
Gabriel cree en Campanita, el Mago de Oz y Cavenaghi
Juan cree en el Conejo de Pascua
Macarena cree en los Reyes Magos, el Mago Capria y Campanita
Diego no cree en nadie
*/

creeEn(gabriel, campanita).
creeEn(gabriel, elMagoDeOz).
creeEn(gabriel, cavenaghi).
creeEn(juan, conejoDePascua).
creeEn(macarena, campanita).
creeEn(macarena, reyesMagos).
creeEn(macarena, magoCapria).

/*
Gabriel quiere ganar la lotería apostando al 5 y al 9, y también quiere ser un futbolista de Arsenal
Juan quiere ser un cantante que venda 100.000 “discos”
Macarena no quiere ganar la lotería, sí ser cantante estilo “Eruca Sativa” y vender 10.000 discos
*/
sueniaCon(gabriel, ganarLaLoteria([5,9])).
sueniaCon(gabriel, serFutbolista(arsenal)).
sueniaCon(juan, serCantante(100000)).
sueniaCon(macarena, serCantante(10000)). %El estilo es irrelevante para el resto de puntos

/*Predicado, átomo, functor, listas, conjunto x extension, universo cerrado*/

%Punto 2:
esAmbiciosa(Persona):-
    sueniaCon(Persona,_),
    findall(Dificultad, dificultad(Persona, Dificultad), Dificultades),
    sum_list(Dificultades, TotalDeDificultad),
    TotalDeDificultad > 20.


dificultad(Persona, Dificultad):-
        sueniaCon(Persona, Suenio),
        calcularDificultadDeSuenio(Suenio, Dificultad).
    

calcularDificultadDeSuenio(serCantante(CantidadDeDiscosVendidos), Dificultad):-
    dificultadSegun(CantidadDeDiscosVendidos, musica, Dificultad).
calcularDificultadDeSuenio(ganarLaLoteria(Numeros), Dificultad):-
        length(Numeros, CantidadDeNumeros),
        Dificultad is 10 * CantidadDeNumeros.
calcularDificultadDeSuenio(serFutbolista(Equipo), Dificultad):-
    dificultadSegun(Equipo, futbol, Dificultad).

dificultadSegun(Equipo, futbol, 3):-
    esChico(Equipo).
dificultadSegun(Equipo, futbol, 16):-
    not(esChico(Equipo)).
dificultadSegun(CantidadVentas, musica, 4):-
    CantidadVentas =< 500000.
dificultadSegun(CantidadVentas, musica, 6):-
    CantidadVentas > 500000.

esChico(arsenal).
esChico(aldosivi).

%Punto 3:
tieneQuimica(Personaje, Persona):-
    creeEn(Persona, Personaje),
    cumplePara(Persona, Personaje).

cumplePara(Persona, campanita):-
    sueniaCon(Persona, Suenio),
    calcularDificultadDeSuenio(Suenio, Dificultad),
    Dificultad < 5.
cumplePara(Persona, Personaje):-
    Personaje \= campanita,
    forall(sueniaCon(Persona, Suenio), esPuro(Suenio)),
    not(esAmbiciosa(Persona)).

esPuro(serFutbolista(_)).
esPuro(serCantante(CantidadDeCanciones)):-
    CantidadDeCanciones < 200000.

%Punto 4:
esAmigaDe(campanita, reyesMagos).
esAmigaDe(campanita, conejoDePascua).
esAmigaDe(conejoDePascua, cavenaghi).

puedeAlegrar(Personaje, Persona):-
    sueniaCon(Persona,_),
    tieneQuimica(Personaje, Persona),
    noEstaEnfermoOAlgunBackupNoEstaEnfermo(Personaje).

noEstaEnfermoOAlgunBackupNoEstaEnfermo(Personaje):-
    not(estaEnfermo(Personaje)).
noEstaEnfermoOAlgunBackupNoEstaEnfermo(Personaje):-
    esAmigaDe(Personaje, OtroPersonaje),
    noEstaEnfermoOAlgunBackupNoEstaEnfermo(OtroPersonaje).

estaEnfermo(conejoDePascua).
estaEnfermo(campanita).
estaEnfermo(reyesMagos).