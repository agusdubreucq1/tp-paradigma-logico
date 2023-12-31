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
/*        Relacionar a una persona con una figurita si la tiene repetida, que se cumple cuando consiguió
          la figurita en cuestión por medios distintos.
          Por ejemplo, Flor tiene repetida la 5 ya que la consiguió en dos paquetes distintos                    */


figuritaRepetida(Persona, Figurita):-
  consiguio(Persona, Figurita, _),
  consiguio(Persona, Figurita, Medio1),
  consiguio(Persona, Figurita, Medio2),
  Medio1 \= Medio2.
/*---------------------------------------------------------------------------------------------------------------*/

/*-------------------------------------------------------2-------------------------------------------------------*/

%ANTES%

/*imagen(Figurita,Categoria)
Categoria:
basica(Personaje)
rompecabezas(NombreRompecabezas)
brillante(Personaje)*/

/*
imagen(1,basica(kitty)).
imagen(1,basica(keroppi)).
imagen(4,basica(0)).
imagen(8,basica(Personaje)):-
  popularidad(Personaje,_).
*/

imagen(2,brillante(kitty)).
imagen(3,brillante(melody)).
imagen(5,rompecabezas(kittyYCompania)).
imagen(6,rompecabezas(kittyYCompania)).
imagen(7,rompecabezas(kittyYCompania)).

%CORRECCION -MODELADO MAS APROPIADO PARA EL TIPO DE IMAGEN-

imagen(1,basica([kitty,keroppi])).
imagen(4,basica([])).
imagen(8,basica(ListaPersonajes)):-
  findall(Personaje,popularidad(Personaje,_),ListaPersonajes).
%%%%%%%%%%%%%%%%%%%%

/*---------------------------------------------------------------------------------------------------------------*/

/*-------------------------------------------------------3-------------------------------------------------------*/

%ANTES%

/* NO SE REQUIERE
popularidades(Figurita,Popularidad):-
  imagen(Figurita,basica(Personaje)),
  popularidad(Personaje,Popularidad).

*/
/*atractivo(Figurita,NivelDeAtractivo):-
  imagen(Figurita,brillante(Personaje)),
  popularidad(Personaje,Popularidad),
  NivelDeAtractivo is 5*Popularidad.*/

/*atractivo(Figurita,NivelDeAtractivo):-
  imagen(Figurita,basica(_)),
  findall(Popularidad,popularidades(Figurita,Popularidad),ListaDePopularidadPersonajes),
  sum_list(ListaDePopularidadPersonajes, NivelDeAtractivo).

atractivo(Figurita,NivelDeAtractivo):-
  imagen(Figurita,basica(Personaje)),
  not(popularidad(Personaje,_)), %(el caso de Personaje = 0)
  NivelDeAtractivo is 0.
*/

/*
atractivo(Figurita,NivelDeAtractivo):-
    imagen(Figurita, rompecabezas(Nombre)),
    findall(FiguraDelRompecabezas, imagen(FiguraDelRompecabezas, rompecabezas(Nombre)), ListaRompecabezas),
    length(ListaRompecabezas,TamLista),
    TamLista =< 2,
    NivelDeAtractivo is 2.

atractivo(Figurita,NivelDeAtractivo):-
  imagen(Figurita, rompecabezas(Nombre)),
  findall(FiguraDelRompecabezas, imagen(FiguraDelRompecabezas, rompecabezas(Nombre)), ListaRompecabezas),
  length(ListaRompecabezas,TamLista),
  TamLista>2,
  NivelDeAtractivo is 0.
*/


valiosa(NumFigurita):-
  consiguio(_,NumFigurita,_), %acoto dominio
  not(figuritaRepetida(_,NumFigurita)). %no existe alguien con esa Figurita repetida

%CORRECCION -GENERAR USANDO PREDICADO ACORDE AL CONTEXTO-

valiosa(NumFigurita):-
  %consiguio(_,Figurita,_), %acoto dominio -- CORRECION
  imagen(NumFigurita,TipoImagen), %importante filtrar solo las figuritas que TIENEN IMAGEN
  atractivo(TipoImagen,NivelDeAtractivo),
  NivelDeAtractivo>7.

%CORRECCION -EL PREDICADO ATRACTIVO DEPENDE DEL TIPO DE IMAGEN, NO DEL NUMERO-

atractivo(brillante(Personaje),NivelDeAtractivo):-
  popularidad(Personaje,Popularidad),
  NivelDeAtractivo is 5*Popularidad.

%ADAPTACION DE PREDICADO ATRACTIVO EN FUNCION DEL NUEVO MODELO DE FIGURITA BASICA

atractivo(basica(ListaPersonajes),NivelDeAtractivo):-
  findall(Popularidad,(member(Personaje, ListaPersonajes),popularidad(Personaje,Popularidad)),ListaDePopularidadPersonajes),
  sum_list(ListaDePopularidadPersonajes, NivelDeAtractivo).
atractivo(basica([]),0).


%MEJORAS EN REPETICION DE LOGICA AL DEFINIR UN ROMPECABEZAS ATRACTIVO

atractivo(rompecabezas(NombreRompecabezas),2):-
  imagen(_,rompecabezas(NombreRompecabezas)), %si es imagen de alguna figurita
  esUnRompecabezasAtractivo(NombreRompecabezas).

atractivo(rompecabezas(NombreRompecabezas),0):-
  imagen(_,rompecabezas(NombreRompecabezas)), %si es imagen de alguna figurita
  not(esUnRompecabezasAtractivo(NombreRompecabezas)).

esUnRompecabezasAtractivo(NombreRompecabezas):-
  %imagen(_,rompecabezas(NombreRompecabezas)), %si es imagen de alguna figurita-para la practica no es necesario que este predicado sea inversible-
  %NombreRompecabezas ya viene ligada del predicado atractivo
  findall(FiguritasDelRompecabezas,imagen(FiguritasDelRompecabezas,rompecabezas(NombreRompecabezas)),ListaFiguritasRompecabezas),
  length(ListaFiguritasRompecabezas,TamLista),
  TamLista=<2.


/*---------------------------------------------------------------------------------------------------------------*/

/*-------------------------------------------------------4-------------------------------------------------------*/
/*              Relacionar a una persona con la imagen más atractiva de las figuritas que consiguió.             */

%ANTES%

/*
figuritaMasAtractiva(Figurita1,Figurita2):-
  atractivo(Figurita1,NivelAtractivo1),
  atractivo(Figurita2,NivelAtractivo2),
  NivelAtractivo1>NivelAtractivo2.
*/


%ADAPTACION PREDICADOS EN FUNCION A LA NUEVA DEFINICION DEL PREDICADO atractivo().

/*                me parece mas claro seguir usando el numero de figurita para encontrar la mas atractiva, 
                  y despues que figuritaMasAtractiva() se encargue de transformarlas en imagen  %(*)             */

laImagenMasAtractivaDe(Persona,ImagenMasAtractiva):-
  imagen(FiguritaMasAtractiva,ImagenMasAtractiva), %busco la figurita que tiene la Imagen evaluada
  consiguio(Persona,FiguritaMasAtractiva,_),
  forall((consiguio(Persona,FiguritasPersona,_),imagen(FiguritasPersona,_),FiguritasPersona\=FiguritaMasAtractiva),
  figuritaMasAtractiva(FiguritaMasAtractiva,FiguritasPersona)).
  %se debe cumplir para TODA FIGURITA DE PERSONA -QUE TENGA IMAGEN- Y SEA DISTINTA A LA MAS ATRACTIVA, que sean menos atractivas

figuritaMasAtractiva(Figurita1,Figurita2):-
  imagen(Figurita1,ImagenMasAtractiva), %(*)
  imagen(Figurita2,ImagenMenosAtractiva),
  atractivo(ImagenMasAtractiva,NivelAtractivo1),
  atractivo(ImagenMenosAtractiva,NivelAtractivo2),
  NivelAtractivo1>NivelAtractivo2.  
  
/*---------------------------------------------------------------------------------------------------------------*/

/*-------------------------------------------------------5-------------------------------------------------------*/
/*      Relacionar a una persona con un canje mediante el cual hizo negocio, si a partir de dicho canje
        consiguió alguna figurita valiosa, y todas las figuritas que le dio a la otra persona en ese canje no
        son valiosas.
        Por ejemplo, en base a los datos iniciales, Flor hizo negocio con el canje con Bobby, ya que le
        dio la 4 y la 6 que no son valiosas y consiguió la 2 que sí lo es.                                       */

                         /*consiguio(Persona, Figurita, canje(Canjeante, ACambio)):-*/

hizoNegocio(Persona,canje(Canjeante,ListaACambio)):-
  valiosa(FiguritaValiosa), %de todas las figuritas valiosas
  consiguio(Persona,FiguritaValiosa,canje(Canjeante,ListaACambio)), %las que consiguió la persona mediante canje
  forall(member(ACambio, ListaACambio),not(valiosa(ACambio))).

/*---------------------------------------------------------------------------------------------------------------*/

/*-------------------------------------------------------6-------------------------------------------------------*/
/*              Saber si una persona necesita una figurita, lo cual se cumple si le falta esa figurita y…
                - o bien ya consiguió todas las otras figuritas del álbum,
                - o bien forma parte de un mismo rompecabezas de otra figurita que sí consiguió.
                Por ejemplo, Flor necesita la 6, cuya imagen es parte del rompecabezas kittyYCompania para el
                cual tiene otra parte.                                                                           */

%ANTES%

/*necesita(Persona, Figurita):-
  noConsiguioLaFigurita(Persona, Figurita),
  forall((consiguio(_,Figuritas,_),Figuritas\=Figurita),consiguio(Persona, Figuritas,_)).

necesita(Persona, Figurita):-
  noConsiguioLaFigurita(Persona, Figurita),
  imagen(Figurita, rompecabezas(Nombre)),

  findall(FiguraDelRompecabezas, 
          imagen(FiguraDelRompecabezas, rompecabezas(Nombre)),
           ListaRompecabezas),
  consiguio(Persona,OtraFigurita,_),
  member(OtraFigurita,ListaRompecabezas).

noConsiguioLaFigurita(Persona, Figurita):-
  consiguio(Persona,_,_),
  consiguio(_,Figurita,_),
  not(consiguio(Persona, Figurita,_)).*/


%CORRECCION -NUEVA LOGICA PARA PREDICADO necesita()-

necesita(Persona,NumFiguritaFaltante):-
  consiguio(Persona,_,_), %consiguio aunque sea 1
  imagen(NumFiguritaFaltante,rompecabezas(NombreRompecabezas)), %la faltante es de un rompecabezas
  not(consiguio(Persona,NumFiguritaFaltante,_)), 
  consiguio(Persona,OtraFigurita,_),
  imagen(OtraFigurita,rompecabezas(NombreRompecabezas)). % y la persona consiguio OtraFigurita del mismo rompecabezas

necesita(Persona,NumFiguritaFaltante):-
  consiguio(Persona,_,_), %consiguio aunque sea 1
  imagen(NumFiguritaFaltante,_), %existe la figurita
  not(consiguio(Persona,NumFiguritaFaltante,_)),
  forall((imagen(FiguritasAlbum,_),FiguritasAlbum\=NumFiguritaFaltante),consiguio(Persona,FiguritasAlbum,_)). %consiguio el resto de album




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
  atractivo(basica([kitty, keroppi,melody,cinnamoroll,pompompurin, littleTwinStars, badtzMaru,gudetama]),23).

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
  laImagenMasAtractivaDe(flor,basica([kitty,keroppi,melody,cinnamoroll,pompompurin,littleTwinStars,badtzMaru,gudetama])).

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

test(conQuePersonaCanjioBobby, set(Persona == [flor])):-
  hizoNegocio(Persona,canje(bobby,_)).

:- end_tests(hizoNegocio).


:- begin_tests(necesitaFigurita).

%Bobby no necesita
test(bobbyNoNecesitaFigurita, set(Cual == [])):-
  necesita(bobby, Cual).


test(quienNecesitaLa5, set(Quien == [andy])):-
  necesita(Quien, 5).


test(andyNecesitaFigurita, set(Cual == [5])):-
    necesita(andy, Cual). 

test(florNecesitaFigurita, set(Cual == [6])):-
  necesita(flor, Cual).

test(andyNecesitala5, nondet):-
  necesita(andy, 5). 

test(andyNoNecesitala6, fail):-
  necesita(andy, 6). 


:- end_tests(necesitaFigurita).

/*test(conQuienNoHizoNegocioBobby, set(Quien == [flor])):-
  not(hizoNegocio(bobby,canje(Quien,_))).
RECORDAR: not() NO ES INVERSIBLE */



