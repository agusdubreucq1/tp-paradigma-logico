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
test(figuritasQueConsiguioFlor, set(Figurita == [5, 4, 7, 2])):-
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