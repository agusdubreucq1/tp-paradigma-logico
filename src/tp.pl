%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Código Inicial
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% popularidad(Personaje, Popularidad)
popularidad(kitty, 5).
popularidad(keroppi, 2).
popularidad(melody, 3).
popularidad(cinnamoroll, 4).
popularidad(pompompurin, 4).
popularidad(littleTwinStars, 2).
popularidad(badtzMaru, 2).
popularidad(gudetama, 1).


% consiguio(Persona, NroFigurita, Medio)

/*
Ejemplo de uso de consiguio/3:

?- consiguio(flor, Figurita, Medio).
Figurita = 5,
Medio = paquete(1) ;
Figurita = 5,
Medio = paquete(2) ;
Figurita = 4,
Medio = canje(andy, [1]) ;
Figurita = 7,
Medio = canje(andy, [1]) ;
Figurita = 2,
Medio = canje(bobby, [4, 6]).

*/
consiguio(andy, 2, paquete(1)).
consiguio(andy, 4, paquete(1)).
consiguio(andy, 7, paquete(2)).
consiguio(andy, 6, paquete(2)).
consiguio(andy, 6, paquete(3)).
consiguio(andy, 1, paquete(3)).
consiguio(andy, 4, paquete(3)).

consiguio(flor, 5, paquete(1)).
consiguio(flor, 5, paquete(2)).
consiguio(flor,8,paquete(3)).

consiguio(bobby, 3, paquete(1)).
consiguio(bobby, 5, paquete(1)).
consiguio(bobby, 7, paquete(2)).
consiguio(bobby, 5, paquete(2)).

consiguio(Persona, Figurita, canje(Canjeante, ACambio)):-
  cambiaron(Persona, ACambio, Canjeante, FiguritasQueRecibio), 
  member(Figurita, FiguritasQueRecibio).
consiguio(Persona, Figurita, canje(Canjeante, ACambio)):-
  cambiaron(Canjeante, FiguritasQueRecibio, Persona, ACambio), 
  member(Figurita, FiguritasQueRecibio).

% cambiaron/4: Predicado auxiliar para evitar repetir información en la definición de consiguio/3,
% ya que ambas personas consiguen las figuritas que da la otra mediante un canje.
% Relaciona a una persona con la lista de sus figuritas que dio en un canje
% con la otra persona que participó del canje y las figuritas que dio a cambio la otra persona.
% 
% No usar directamente en la implementación de los requerimientos.
% Vale extenderlo para agregar datos de prueba.

cambiaron(andy, [4,7], flor, [1]).
cambiaron(bobby, [2], flor, [4, 6]).

%andy tiene la 1 
%bobby tiene la 4 y la 6
%flor tiene la 4, 7 y 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Implementar nuevos predicados aquí...

/*-------------------------------------------------------1-------------------------------------------------------*/
/*Relacionar a una persona con una figurita si la tiene repetida, que se cumple cuando consiguió
la figurita en cuestión por medios distintos.
Por ejemplo, Flor tiene repetida la 5 ya que la consiguió en dos paquetes distintos*/


%OPCION 1 SIN FINDALL
/*figuritaRepetida(Persona,Figurita):-
  consiguio(Persona,Figurita,_), %genero/verifico que la Persona tenga la Figurita
  repetida(Persona,Figurita). %verifica si la Figurita está repetida entre las Figuritas de la Persona

repetida(Persona,Figurita):-
  consiguio(Persona,Figuritas,_), %liga todas las Figuritas de la Persona en cuestion
  consiguio(Persona,Figurita,Medio1), %analizo el medio por el que obtuvo la figurita
  Figuritas=Figurita, % Figuritas ahora tiene las iguales a Figurita
  consiguio(Persona,Figuritas,Medio2), 
  Medio1\=Medio2. %Busca si existe alguna tal que el medio por el cual se obtuvo sea distinto al medio de la Figurita
*/

%OPCION 2 CON FINDALL
figuritaRepetida(Persona,Figurita):-
  consiguio(Persona,Figurita,_), %acoto dominio
  findall(Medio,consiguio(Persona,Figurita,Medio),ListaDeMediosDeObtencionFigurita),
  length(ListaDeMediosDeObtencionFigurita, CantidadMedios),
  CantidadMedios>1.
/*---------------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------------------2-------------------------------------------------------*/

/*imagen(Figurita,Categoria)
Categoria:
basica(Personaje)
rompecabezas(NombreRompecabezas,ListaOrdenadaDeFiguritasQueLaComponen)
brillante(Personaje)*/

imagen(1,basica(kitty)).
imagen(1,basica(keroppi)).
imagen(2,brillante(kitty)).
imagen(3,brillante(melody)).
imagen(4,basica(0)).
imagen(5,rompecabezas(kittyYCompania,[5,6,7])).
imagen(8,basica(Personaje)):-
  popularidad(Personaje,_).


/*---------------------------------------------------------------------------------------------------------------*/

/*-------------------------------------------------------3-------------------------------------------------------*/


valiosa(Figurita):-
  consiguio(_,Figurita,_), %acoto dominio
  not(figuritaRepetida(_,Figurita)). %no existe alguien con esa Figurita repetida

valiosa(Figurita):-
  consiguio(_,Figurita,_), %acoto dominio
  imagen(Figurita,_), %importante filtrar solo las figuritas que TIENEN IMAGEN
  atractivo(Figurita,NivelDeAtractivo),
  NivelDeAtractivo>7.

popularidades(Figurita,Popularidad):-
  imagen(Figurita,basica(Personaje)),
  popularidad(Personaje,Popularidad).

atractivo(Figurita,NivelDeAtractivo):-
  imagen(Figurita,brillante(Personaje)),
  popularidad(Personaje,Popularidad),
  NivelDeAtractivo is 5*Popularidad.

atractivo(Figurita,NivelDeAtractivo):-
  imagen(Figurita,basica(Personaje)),
  findall(Popularidad,popularidades(Figurita,Popularidad),ListaDePopularidadPersonajes),
  sum_list(ListaDePopularidadPersonajes, NivelDeAtractivo).


atractivo(Figurita,NivelDeAtractivo):-
  imagen(Figurita,basica(Personaje)),
  not(popularidad(Personaje,_)), %(el caso de Personaje = 0)
  NivelDeAtractivo is 0.

atractivo(Figurita,NivelDeAtractivo):-
  imagen(Figurita,rompecabezas(NombreRompecabezas,ListaOrdenadaDeFiguritasQueLaComponen)),
  length(ListaOrdenadaDeFiguritasQueLaComponen,TamLista),
  TamLista<=2,
  NivelDeAtractivo is 2.

atractivo(Figurita,NivelDeAtractivo):-
  imagen(Figurita,rompecabezas(NombreRompecabezas,ListaOrdenadaDeFiguritasQueLaComponen)),
  length(ListaOrdenadaDeFiguritasQueLaComponen,TamLista),
  TamLista>2,
  NivelDeAtractivo is 0.

/*---------------------------------------------------------------------------------------------------------------*/

/*-------------------------------------------------------4-------------------------------------------------------*/
/* Relacionar a una persona con la imagen más atractiva de las figuritas que consiguió.*/

laImagenMasAtractivaDe(Persona,ImagenMasAtractiva):-
  imagen(FiguritaMasAtractiva,ImagenMasAtractiva), %busco la figurita que tiene la Imagen evaluada
  consiguio(Persona,FiguritaMasAtractiva,_),
  forall((consiguio(Persona,FiguritasPersona,_),imagen(FiguritasPersona,_),FiguritasPersona\=FiguritaMasAtractiva),
  figuritaMasAtractiva(FiguritaMasAtractiva,FiguritasPersona)).
  %se debe cumplir para TODA FIGURITA DE PERSONA -QUE TENGA IMAGEN- Y SEA DISTINTA A LA MAS ATRACTIVA, que sean menos atractivas

figuritaMasAtractiva(Figurita1,Figurita2):-
  atractivo(Figurita1,NivelAtractivo1),
  atractivo(Figurita2,NivelAtractivo2),
  NivelAtractivo1>NivelAtractivo2.
  
/*---------------------------------------------------------------------------------------------------------------*/

/*-------------------------------------------------------5-------------------------------------------------------*/
/*Relacionar a una persona con un canje mediante el cual hizo negocio, si a partir de dicho canje
consiguió alguna figurita valiosa, y todas las figuritas que le dio a la otra persona en ese canje no
son valiosas.
Por ejemplo, en base a los datos iniciales, Flor hizo negocio con el canje con Bobby, ya que le
dio la 4 y la 6 que no son valiosas y consiguió la 2 que sí lo es.*/

/*consiguio(Persona, Figurita, canje(Canjeante, ACambio)):-*/

hizoNegocio(Persona,canje(Canjeante,ListaACambio)):-
  valiosa(FiguritaValiosa), %de todas las figuritas valiosas
  consiguio(Persona,FiguritaValiosa,canje(Canjeante,ListaACambio)), %las que consiguió la persona mediante canje
  forall(consiguio(Persona,FiguritaValiosa,canje(_,[ACambio])),not(valiosa(ACambio))).
    

/*Prueba recorrer lista
aCambio([2,3]).
forall(aCambio([X]), valiosa(X)).

prueba extra
valiosa(FiguritaValiosa),consiguio(flor,FiguritaValiosa,canje(Quien,Acambio)). */
/*---------------------------------------------------------------------------------------------------------------*/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Pruebas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Tests de ejemplo sobre código base
:- begin_tests(consiguio).

%% Testeo de consultas que esperan que sean ciertas
test(florConsiguioLa5EnSuPrimerPaquete, nondet):-
  consiguio(flor, 5, paquete(1)).
test(florConsiguioLa2EnUnCanjeConBobby, nondet):-
  consiguio(flor, 2, canje(bobby, _)).

%% Testeo de consultas que esperan que sean falsas
test(florConsiguioLa5EnSuPrimerPaquete, fail):-
  consiguio(flor, 2, paquete(1)).

%% Testeo de consultas existenciales con múltiples respuestas => inversibilidad
test(figuritasQueConsiguioFlor, set(Figurita == [5, 4, 7, 2,8])):-
  consiguio(flor, Figurita, _).

%% Test basado en condiciones más complejas
test(cuandoDosPersonasCambianFiguritasAmbasConsiguenFiguritasPorCanjeConLaOtraIncluyendoLasQueLeDieronALaOtra, nondet):-
  consiguio(andy, _, canje(flor, [4,7])),
  consiguio(flor, _, canje(andy, [1])).

:- end_tests(consiguio).

%% Tests de requerimiento, implementar aquí...


:- begin_tests(figuritaRepetida).

%% Testeo de consultas que esperan que sean ciertas
test(florTieneRepetidaLa5, nondet):-
  figuritaRepetida(flor, 5).
test(andyTieneRepetidaLa4, nondet):-
  figuritaRepetida(andy, 4).

%% Testeo de consultas que esperan que sean falsas
test(bobbyTieneRepetidaLa3, fail):-
  figuritaRepetida(bobby, 3).

test(bobbyTieneRepetidaLa9, fail):-
  figuritaRepetida(bobby, 9).

%% Testeo de consultas existenciales con múltiples respuestas => inversibilidad
test(figuritasRepetidasDeAndy, set(Figurita == [1,6,4])):-
  figuritaRepetida(andy, Figurita).

   %Nota:tambien suma la figurata 1 que consiguio andy mediante el intercambio con flor
   /*4 ?- consiguio(andy,1,QuéMedio).
          QuéMedio = paquete(3) ;
          QuéMedio = canje(flor, [4, 7]) ;*/

test(quienTieneLa5Repetida, set(Persona == [flor,bobby])):-
  figuritaRepetida(Persona, 5).

:- end_tests(figuritaRepetida).

/*extra*/
:- begin_tests(atractivo).

%% Testeo de consultas que esperan que sean ciertas
test(atractivoDeFigurita8es23, nondet):-
  atractivo(8,23).

:- end_tests(atractivo).


:- begin_tests(valiosa).

%% Testeo de consultas que esperan que sean ciertas
test(figurita7esValiosaPorqueNadieLaTieneRepetida, nondet):-
  valiosa(7).
test(figurita3EsValiosaPorqueSuNivelDeAtractivoEsMayorA7, nondet):-
  valiosa(3).

%% Testeo de consultas que esperan que sean falsas
test(figurita1NOesValiosaPorqueAndyLaTieneRepetida, fail):-
  valiosa(1).
test(figurita4NOesValiosaPorqueSuNivelDeAtractivoEsMenorA7, fail):-
  valiosa(4).

%% Testeo de consultas existenciales con múltiples respuestas => inversibilidad
test(figuritasValiosasConseguidas, set(Figurita == [3, 2, 7, 8])):-
  valiosa(Figurita).

:- end_tests(valiosa).

:- begin_tests(laImagenMasAtractivaDe).

%% Testeo de consultas que esperan que sean ciertas
test(laMasAtractivaDeAndyEsFigurita2, nondet):-
  laImagenMasAtractivaDe(andy,brillante(kitty)).
test(laMasAtractivaDeFlorEs2, nondet):-
  laImagenMasAtractivaDe(flor,brillante(kitty)).
    
test(laMasAtractivaDeBobbyEs3, nondet):-
  laImagenMasAtractivaDe(bobby,brillante(melody)).

%% Testeo de consultas que esperan que sean falsas
test(laMasAtractivaDeBobbyNOEsFigurita2, fail):-
  laImagenMasAtractivaDe(bobby,brillante(kitty)).

test(laMasAtractivaDeFlorNOEsFigurita8, fail):-
  laImagenMasAtractivaDe(flor,basica(kitty,keroppi,melody,cinnamoroll,pompompurin,littleTwinStars,badtzMaru,gudetama)).

%% Testeo de consultas existenciales con múltiples respuestas => inversibilidad
test(figuritaMasAtractivaDeFlor, set(ImagenFigurita == [brillante(kitty)])):-
  laImagenMasAtractivaDe(flor,ImagenFigurita).
 %recibio la figurita 2 en un canje con bobby 

test(figuritaMasAtractivaDeAndy, set(ImagenFigurita == [brillante(kitty)])):-
  laImagenMasAtractivaDe(andy,ImagenFigurita).

test(paraQuienLa3EsSuMasAtractiva, set(Persona == [bobby])):-
  laImagenMasAtractivaDe(Persona,brillante(melody)).

:- end_tests(laImagenMasAtractivaDe).

:- begin_tests(hizoNegocio).

/*Por ejemplo, en base a los datos iniciales, Flor hizo negocio con el canje con Bobby, ya que le
dio la 4 y la 6 que no son valiosas y consiguió la 2 que sí lo es.*/

%% Testeo de consultas que esperan que sean ciertas
test(florHizoNegocioConElCanjeConBobby, nondet):-
  hizoNegocio(flor,canje(bobby,[4,6])). % flor le dio a bobby la 4 y la 6 por la 2

test(florHizoNegocioConElCanjeConAndy, nondet):-
  hizoNegocio(flor,canje(andy,[1])). % andy le dio a flor la 4 y la 7 por la 1, (la 7 es valiosa, la 1 no)

%% Testeo de consultas que esperan que sean falsas
test(andyNOHizoNegocioConElCanjeConFlor, fail):-
  hizoNegocio(andy,canje(flor,[4,7])). % andy le dio a flor la 4 y la 7 por la 1

test(bobbyNOHizoNegocioConElCanjeConFlor, fail):-
  hizoNegocio(bobby,canje(flor,[2])). %bobby le dio a flor la 2

%% Testeo de consultas existenciales con múltiples respuestas => inversibilidad
test(conQueCanjeHizoNegocioAndy, set(CanjeNegocio == [])):-
  hizoNegocio(andy,CanjeNegocio). %con ninguno

  test(conQueCanjeHizoNegocioFlor, set(CanjeNegocio == [canje(andy,[1]),canje(bobby,[4,6])])):-
    hizoNegocio(flor,CanjeNegocio). %con ninguno

test(conQuienHizoNegocioFlor, set(Quien == [bobby,andy])):-
  hizoNegocio(flor,canje(Quien,_)).

/*test(conQuienNoHizoNegocioBobby, set(Quien == [flor])):-
  not(hizoNegocio(bobby,canje(Quien,_))).
RECORDAR: not() NO ES INVERSIBLE */
/*


:- end_tests(hizoNegocio).

