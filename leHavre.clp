(defclass JUGADOR
    (is-a USER)
    (slot id (type INTEGER))
    (slot dinero (type INTEGER) (default 0))
)

(defclass RECURSO
    (is-a USER)
    (slot tipo (type SYMBOL))
    (slot valor (type INTEGER))
)

(defclass RECURSO_ALIMENTICIO
    (is-a RECURSO)
    (slot tipo (type SYMBOL) (allowed-symbols GANADO GRANO))
)

(defclass RECURSO_COMIDA
    (is-a RECURSO)
    (slot tipo (type SYMBOL) (allowed-symbols PESCADO PESCADOAHUMADO CARNE PAN))
    (slot comida (type INTEGER))
    (slot comprobado (type SYMBOL) (allowed-symbols Si No)(default No))
)

(defclass RECURSO_MATERIAL
    (is-a RECURSO)
    (slot tipo (type SYMBOL) (allowed-symbols LADRILLO ARCILLA ACERO HIERRO CUERO PIELES))
)

(defclass RECURSO_ENERGETICO
    (is-a RECURSO)
    (slot tipo (type SYMBOL) (allowed-symbols MADERA CARBONVEGETAL CARBON COQUE))
    (slot energia (type INTEGER) (default 0))
)

(defclass CARTA_RONDA
    (is-a USER)
    (slot numRonda (type INTEGER) (default 0))
    (slot pagoComida (type INTEGER) (default 0))
    (slot cosecha (type SYMBOL) (allowed-symbols Si No))
)

(defclass CARTA_CONSTRUCCION
    (is-a USER)
    (slot id (type INTEGER))
    (slot tipo (type SYMBOL))
    (slot costeCompra (type INTEGER)) ;coste de comprar la carta
    (slot valor (type INTEGER)) ; valor en puntos de la carta
    (slot desplegada (type SYMBOL) (allowed-symbols Si No) (default Si))
    (slot construido (type SYMBOL) (allowed-symbols Si No) (default No))
)

(defclass CARTA_BARCO
    (is-a CARTA_CONSTRUCCION)
    (slot tipo (allowed-symbols MADERA HIERRO ACERO))
    (slot recompensaComida (type INTEGER))
)

(defclass CARTA_EDIFICIO
    (is-a CARTA_CONSTRUCCION)
    (slot tipo (allowed-symbols CONSTRUCTORA INMOBILARIA PESQUERIA ASERRADERO PANADERIACOMUN HORNODECARBON AHUMADOR MATADERO ASTILLERO PANADERIAESPECIAL MINA LONJA))
    (slot costeUso (type INTEGER));coste en comida de su uso por un trabajador
)

; (defclass CARTA_EDIFICIO_ESPECIAL
;     (is-a CARTA_CONSTRUCCION)
;     (slot tipo (allowed-symbols PANADERIA MINA LONJA))
;     (slot costeUso (type INTEGER));coste en comida de su uso por un trabajador
; )

(defclass ZONA_OFERTA
    (is-a USER)
    (slot nombre (type SYMBOL) (allowed-symbols FRANCOS PESCADO MADERA ARCILLA HIERRO GANADO GRANO))
    (slot cantidad (type INTEGER)(default 0))
)

(defclass LOSETA
    (is-a USER)
    (slot id (type INTEGER))
    (slot interes (type SYMBOL) (allowed-symbols Si No)(default No))
)

;--------------------------RELACIONES----------------------------------------------

(defclass JUGADOR_LOSETA
    (is-a USER)
    (slot jugador (type INTEGER))
    (slot losetaActual (type INTEGER))
)

(defclass TRABAJA_EN
    (is-a USER)
    (slot trabajador (type INTEGER));id del jugador
    (slot carta (type INTEGER)) ; id de la carta en la que está el trabajador,
    ;no pongo nombre porque puede haber varias cartas con el mismo nombre 
)

(defclass RECURSO_JUGADOR
    (is-a USER)
    (slot jugador (type INTEGER));id del jugador
    (slot tipoRecurso (type SYMBOL)) ; nombre del recurso
    (slot cantidadRecurso (type INTEGER) (default 0))
)

(defclass PROPIETARIO_CARTA
    (is-a USER)
    (slot propietario (type INTEGER)) ;id del jugador
    (slot carta (type INTEGER)) ; id de la carta
) 

(defclass COSTE_CONSTRUCCION_EDIFICIO
    (is-a USER)
    (slot edificio (type INTEGER)) ;id del edificio
    (slot recurso (type SYMBOL)) ; tipo de recurso para construirla
    (slot cantidadRecurso (type INTEGER)) ;cantidad de recurso para construirla
)

(defclass COSTE_CONSTRUCCION_BARCO
    (is-a USER)
    (slot barco (type INTEGER)) ;id del barco
    (slot recurso (type SYMBOL)); tipo de recurso para construirla
    (slot cantidadRecurso (type INTEGER)) ;cantidad de recurso para construirla
    (slot energiaNecesaria (type INTEGER));energía construir barco
)

(defclass RECURSO_LOSETA
    (is-a USER)
    (slot loseta (type INTEGER)) ;id de la loseta
    (slot recurso (type SYMBOL)) ; tipo de recurso a suministrar
    (slot cantidadRecurso (type INTEGER)(default 1)) ;cantidad de recurso a suministrar
)

;Recompensa por el uso de las cartas
(defclass BONUS_USO_EDIFICIO
    (is-a USER)
    (slot carta (type INTEGER))
    ;Puede tener valor NULL (fishery) contemplar en las reglas
    (slot recurso (type SYMBOL)(allowed-symbols NULL PESCADO PESCADOAHUMADO MADERA CARBONVEGETAL LADRILLO ARCILLA ACERO HIERRO CARNE GANADO PAN GRANO CARBON COQUE CUERO PIELES))
    ;puede tener valor FRANCO, contemplar en la regla
    (slot recursoRecompensa (type SYMBOL)(allowed-symbols FRANCO PESCADO PESCADOAHUMADO MADERA CARBONVEGETAL LADRILLO ARCILLA ACERO HIERRO CARNE GANADO PAN GRANO CARBON COQUE CUERO PIELES))
    (slot cantidadRecompensa (type INTEGER))
    (slot bonusAplicado (type SYMBOL) (allowed-symbols Si No)(default No))
)

(defclass CARTA_RONDA_CONSTRUCCION
    (is-a USER)
    (slot ronda (type INTEGER))
    (slot cartaConstruir (type INTEGER));Puede ser un barco o un edificio especial
)

;--------------------------CARGA INSTANCIAS Y HECHOS INICIALES-----------------------------------------
; (definstances propietario-inicial
;     (of PROPIETARIO_CARTA (propietario 2)(carta 21))
; ) 

(definstances jugadores-iniciales
    (of JUGADOR (id 1)(dinero 5));En el juego corto empiezan con 5 francos
    (of JUGADOR (id 2)(dinero 5))
)

(definstances recursos-iniciales
    (of RECURSO_COMIDA (tipo PESCADO)(valor 1)(comida 1))
    (of RECURSO_COMIDA (tipo PESCADOAHUMADO)(valor 2)(comida 2))
    (of RECURSO_COMIDA (tipo PAN)(valor 3)(comida 2))
    (of RECURSO_COMIDA (tipo CARNE)(valor 2)(comida 3))

    (of RECURSO_ALIMENTICIO (tipo GRANO)(valor 1))
    (of RECURSO_ALIMENTICIO (tipo GANADO)(valor 3))

    (of RECURSO_MATERIAL (tipo ARCILLA)(valor 1))
    (of RECURSO_MATERIAL (tipo LADRILLO)(valor 2))
    (of RECURSO_MATERIAL (tipo HIERRO)(valor 2))
    (of RECURSO_MATERIAL (tipo ACERO)(valor 8))
    (of RECURSO_MATERIAL (tipo PIELES)(valor 2))
    (of RECURSO_MATERIAL (tipo CUERO)(valor 4))

    (of RECURSO_ENERGETICO (tipo MADERA)(valor 1)(energia 1))
    (of RECURSO_ENERGETICO (tipo CARBONVEGETAL)(valor 2)(energia 3))
    (of RECURSO_ENERGETICO (tipo CARBON)(valor 3)(energia 3))
    (of RECURSO_ENERGETICO (tipo COQUE)(valor 5)(energia 10))
)

(definstances cartas-ronda-ininiciales
    (of CARTA_RONDA (numRonda 1)(pagoComida 5)(cosecha No))
    (of CARTA_RONDA (numRonda 2)(pagoComida 7)(cosecha Si))
    (of CARTA_RONDA (numRonda 3)(pagoComida 9)(cosecha No))
    (of CARTA_RONDA (numRonda 4)(pagoComida 10)(cosecha Si))
    (of CARTA_RONDA (numRonda 5)(pagoComida 12)(cosecha Si))

)

(definstances cartas-ininiciales-desplegadas
    (of CARTA_EDIFICIO (id 20)(tipo CONSTRUCTORA)(costeCompra 0)(valor 4)(construido Si)(costeUso 0))
    (of CARTA_EDIFICIO (id 21)(tipo CONSTRUCTORA)(costeCompra 0)(valor 6)(construido Si)(costeUso 1))
    (of CARTA_EDIFICIO (id 22)(tipo INMOBILARIA)(costeCompra 0)(valor 8)(construido Si)(costeUso 2))
)

(definstances cartas-barcos
    (of CARTA_BARCO (id 30)(tipo MADERA)(costeCompra 14)(valor 4)(desplegada No)(recompensaComida 4))
    (of CARTA_BARCO (id 31)(tipo HIERRO)(costeCompra 20)(valor 4)(desplegada No)(recompensaComida 5))
    (of CARTA_BARCO (id 32)(tipo ACERO)(costeCompra 30)(valor 10)(desplegada No)(recompensaComida 7));Mirar si quitarlo o no
)

(definstances mazo-cartas
    ;Edificios comunes
    (of CARTA_EDIFICIO (id 1)(tipo PESQUERIA)(costeCompra 0)(valor 10)(costeUso 0));Fishery
    (of CARTA_EDIFICIO (id 2)(tipo ASERRADERO)(costeCompra 0)(valor 8)(costeUso 1));Joinery
    (of CARTA_EDIFICIO (id 3)(tipo PANADERIACOMUN)(costeCompra 0)(valor 8)(costeUso 1));Bakehouse
    (of CARTA_EDIFICIO (id 4)(tipo HORNODECARBON)(costeCompra 0)(valor 8)(costeUso 0));CharcoalKiln
    (of CARTA_EDIFICIO (id 5)(tipo AHUMADOR)(costeCompra 0)(valor 8)(costeUso 2));Smokehouse
    (of CARTA_EDIFICIO (id 6)(tipo MATADERO)(costeCompra 0)(valor 8)(costeUso 2));Abattoir
    (of CARTA_EDIFICIO (id 7)(tipo ASTILLERO)(costeCompra 0)(valor 14)(costeUso 2));Wharf
    ;Edificios especiales
    (of CARTA_EDIFICIO (id 8)(tipo PANADERIAESPECIAL)(costeCompra 0)(valor 6)(desplegada No)(costeUso 1));Bakery
    (of CARTA_EDIFICIO (id 9)(tipo MINA)(costeCompra 0)(valor 6)(desplegada No)(costeUso 1));Iron Mine & Coal Seam
    (of CARTA_EDIFICIO (id 10)(tipo LONJA)(costeCompra 0)(valor 4)(desplegada No)(costeUso 1));Fish Market
)

(definstances zonaOferta-iniciales
    (of ZONA_OFERTA (nombre FRANCOS))
    (of ZONA_OFERTA (nombre PESCADO))
    (of ZONA_OFERTA (nombre MADERA))
    (of ZONA_OFERTA (nombre ARCILLA))
    (of ZONA_OFERTA (nombre HIERRO))
    (of ZONA_OFERTA (nombre GRANO))
    (of ZONA_OFERTA (nombre GANADO))
)

(definstances losetas-iniciales
    (of LOSETA (id 1));Tiene 1 madera y 1 ganado
    (of LOSETA (id 2));Tiene 1 pescado y 1 trigo
    (of LOSETA (id 3));Tiene 1 madera y 1 arcilla
    (of LOSETA (id 4));Tiene 1 arcilla y 1 pesaco
    (of LOSETA (id 5));Tiene 1 hierro y 1 franco
    (of LOSETA (id 6));Tiene 1 madera y 1 franco
    (of LOSETA (id 7)(interes Si));Tiene 1 pescado y 1 madera
)

;..................INSTANCIAMOS RELACIONES.............

;Posiciones iniciales de los jugadores
(definstances loseta-inicial-jugador
    (of JUGADOR_LOSETA (jugador 1)(losetaActual 1))
    (of JUGADOR_LOSETA (jugador 2)(losetaActual 2))
)

(definstances trabajador-inicial
    (of TRABAJA_EN (trabajador 1)(carta 0));Inicialmente no trabajan en ninguna carta (id 0)
    (of TRABAJA_EN (trabajador 2)(carta 0));Inicialmente no trabajan en ninguna carta (id 0)
)
(definstances recursos-iniciales-jugador
    (of RECURSO_JUGADOR (jugador 1)(tipoRecurso PESCADO)(cantidadRecurso 2))
    (of RECURSO_JUGADOR (jugador 1)(tipoRecurso PESCADOAHUMADO)(cantidadRecurso 0))
    (of RECURSO_JUGADOR (jugador 1)(tipoRecurso MADERA)(cantidadRecurso 2))
    (of RECURSO_JUGADOR (jugador 1)(tipoRecurso CARBONVEGETAL)(cantidadRecurso 0))
    (of RECURSO_JUGADOR (jugador 1)(tipoRecurso ARCILLA)(cantidadRecurso 2))
    (of RECURSO_JUGADOR (jugador 1)(tipoRecurso LADRILLO)(cantidadRecurso 0))
    (of RECURSO_JUGADOR (jugador 1)(tipoRecurso HIERRO)(cantidadRecurso 0))
    (of RECURSO_JUGADOR (jugador 1)(tipoRecurso ACERO)(cantidadRecurso 2))
    (of RECURSO_JUGADOR (jugador 1)(tipoRecurso CARBON)(cantidadRecurso 2))
    (of RECURSO_JUGADOR (jugador 1)(tipoRecurso COQUE)(cantidadRecurso 0))
    (of RECURSO_JUGADOR (jugador 1)(tipoRecurso PIELES)(cantidadRecurso 2))
    (of RECURSO_JUGADOR (jugador 1)(tipoRecurso CUERO)(cantidadRecurso 0))
    (of RECURSO_JUGADOR (jugador 1)(tipoRecurso GANADO)(cantidadRecurso 1))
    (of RECURSO_JUGADOR (jugador 1)(tipoRecurso CARNE)(cantidadRecurso 0))
    (of RECURSO_JUGADOR (jugador 1)(tipoRecurso GRANO)(cantidadRecurso 0))
    (of RECURSO_JUGADOR (jugador 1)(tipoRecurso PAN)(cantidadRecurso 0))

    (of RECURSO_JUGADOR (jugador 2)(tipoRecurso PESCADO)(cantidadRecurso 2))
    (of RECURSO_JUGADOR (jugador 2)(tipoRecurso PESCADOAHUMADO)(cantidadRecurso 0))
    (of RECURSO_JUGADOR (jugador 2)(tipoRecurso MADERA)(cantidadRecurso 2))
    (of RECURSO_JUGADOR (jugador 2)(tipoRecurso CARBONVEGETAL)(cantidadRecurso 0))
    (of RECURSO_JUGADOR (jugador 2)(tipoRecurso ARCILLA)(cantidadRecurso 2))
    (of RECURSO_JUGADOR (jugador 2)(tipoRecurso LADRILLO)(cantidadRecurso 0))
    (of RECURSO_JUGADOR (jugador 2)(tipoRecurso HIERRO)(cantidadRecurso 0))
    (of RECURSO_JUGADOR (jugador 2)(tipoRecurso ACERO)(cantidadRecurso 2))
    (of RECURSO_JUGADOR (jugador 2)(tipoRecurso CARBON)(cantidadRecurso 2))
    (of RECURSO_JUGADOR (jugador 2)(tipoRecurso COQUE)(cantidadRecurso 0))
    (of RECURSO_JUGADOR (jugador 2)(tipoRecurso PIELES)(cantidadRecurso 2))
    (of RECURSO_JUGADOR (jugador 2)(tipoRecurso CUERO)(cantidadRecurso 0))
    (of RECURSO_JUGADOR (jugador 2)(tipoRecurso GANADO)(cantidadRecurso 2))
    (of RECURSO_JUGADOR (jugador 2)(tipoRecurso CARNE)(cantidadRecurso 0))
    (of RECURSO_JUGADOR (jugador 2)(tipoRecurso GRANO)(cantidadRecurso 0))
    (of RECURSO_JUGADOR (jugador 2)(tipoRecurso PAN)(cantidadRecurso 0))

)

(definstances coste-construccion-edificios
    ;PESQUERIA
    (of COSTE_CONSTRUCCION_EDIFICIO (edificio 1)(recurso MADERA)(cantidadRecurso 1))
    (of COSTE_CONSTRUCCION_EDIFICIO (edificio 1)(recurso ARCILLA)(cantidadRecurso 1))
    ;ASERRADERO
    (of COSTE_CONSTRUCCION_EDIFICIO (edificio 2)(recurso MADERA)(cantidadRecurso 3))
    ;PANADERIA
    (of COSTE_CONSTRUCCION_EDIFICIO (edificio 3)(recurso ARCILLA)(cantidadRecurso 2))
    ;HORNO DE CARBON
    (of COSTE_CONSTRUCCION_EDIFICIO (edificio 4)(recurso ARCILLA)(cantidadRecurso 1))
    ;AHUMADOR
    (of COSTE_CONSTRUCCION_EDIFICIO (edificio 5)(recurso MADERA)(cantidadRecurso 2))
    (of COSTE_CONSTRUCCION_EDIFICIO (edificio 5)(recurso ARCILLA)(cantidadRecurso 1))
    ;MATADERO
    (of COSTE_CONSTRUCCION_EDIFICIO (edificio 6)(recurso MADERA)(cantidadRecurso 1))
    (of COSTE_CONSTRUCCION_EDIFICIO (edificio 6)(recurso ARCILLA)(cantidadRecurso 1))
    (of COSTE_CONSTRUCCION_EDIFICIO (edificio 6)(recurso HIERRO)(cantidadRecurso 1))
    ;ASTILLERO
    (of COSTE_CONSTRUCCION_EDIFICIO (edificio 7)(recurso MADERA)(cantidadRecurso 2))
    (of COSTE_CONSTRUCCION_EDIFICIO (edificio 7)(recurso ARCILLA)(cantidadRecurso 2))
    (of COSTE_CONSTRUCCION_EDIFICIO (edificio 7)(recurso HIERRO)(cantidadRecurso 2))
)

(definstances coste-construccion-barcos
    (of COSTE_CONSTRUCCION_BARCO (barco 30)(recurso MADERA)(cantidadRecurso 5)(energiaNecesaria 3))
    (of COSTE_CONSTRUCCION_BARCO (barco 31)(recurso HIERRO)(cantidadRecurso 4)(energiaNecesaria 3))
    (of COSTE_CONSTRUCCION_BARCO (barco 32)(recurso ACERO)(cantidadRecurso 2)(energiaNecesaria 3));MIRAR SI QUITARLO O KLK
)

(definstances recursosLoseta-iniciales
    (of RECURSO_LOSETA (loseta 1)(recurso MADERA))
    (of RECURSO_LOSETA (loseta 1)(recurso GANADO))

    (of RECURSO_LOSETA (loseta 2)(recurso PESCADO))
    (of RECURSO_LOSETA (loseta 2)(recurso GRANO))

    (of RECURSO_LOSETA (loseta 3)(recurso MADERA))
    (of RECURSO_LOSETA (loseta 3)(recurso ARCILLA))

    (of RECURSO_LOSETA (loseta 4)(recurso ARCILLA))
    (of RECURSO_LOSETA (loseta 4)(recurso PESCADO))

    (of RECURSO_LOSETA (loseta 5)(recurso HIERRO))
    (of RECURSO_LOSETA (loseta 5)(recurso FRANCOS))

    (of RECURSO_LOSETA (loseta 6)(recurso MADERA))
    (of RECURSO_LOSETA (loseta 6)(recurso FRANCOS))

    (of RECURSO_LOSETA (loseta 7)(recurso PESCADO))
    (of RECURSO_LOSETA (loseta 7)(recurso MADERA))
)

;BONUS USO DE CARTAS
(definstances recompensas-edificios
    ;COMUNES
    (of BONUS_USO_EDIFICIO (carta 1)(recurso NULL)(recursoRecompensa PESCADO)(cantidadRecompensa 3))
    (of BONUS_USO_EDIFICIO (carta 2)(recurso MADERA)(recursoRecompensa FRANCO)(cantidadRecompensa 5));5 francos es la recompensa por una madera
    (of BONUS_USO_EDIFICIO (carta 3)(recurso GRANO)(recursoRecompensa PAN)(cantidadRecompensa 1));Necesita 1/2 energía
    (of BONUS_USO_EDIFICIO (carta 4)(recurso MADERA)(recursoRecompensa CARBONVEGETAL)(cantidadRecompensa 1))
    (of BONUS_USO_EDIFICIO (carta 5)(recurso PESCADO)(recursoRecompensa PESCADOAHUMADO)(cantidadRecompensa 6));Necesita 1 energía
    (of BONUS_USO_EDIFICIO (carta 6)(recurso GANADO)(recursoRecompensa CARNE)(cantidadRecompensa 1))
    (of BONUS_USO_EDIFICIO (carta 6)(recurso GANADO)(recursoRecompensa PIELES)(cantidadRecompensa 1));En verdad es 1/2 PIELES
    ;ESPECIALES
    (of BONUS_USO_EDIFICIO (carta 8)(recurso PAN)(recursoRecompensa FRANCO)(cantidadRecompensa 3))
    (of BONUS_USO_EDIFICIO (carta 9)(recurso NULL)(recursoRecompensa HIERRO)(cantidadRecompensa 2))
    (of BONUS_USO_EDIFICIO (carta 9)(recurso NULL)(recursoRecompensa CARBON)(cantidadRecompensa 1))
    (of BONUS_USO_EDIFICIO (carta 10)(recurso PESCADO)(recursoRecompensa FRANCO)(cantidadRecompensa 2))
)

(definstances cartas-rondas-construir
    (of CARTA_RONDA_CONSTRUCCION (ronda 1)(cartaConstruir 9))
    (of CARTA_RONDA_CONSTRUCCION (ronda 2)(cartaConstruir 30))
    (of CARTA_RONDA_CONSTRUCCION (ronda 3)(cartaConstruir 8))
    (of CARTA_RONDA_CONSTRUCCION (ronda 4)(cartaConstruir 31))
    (of CARTA_RONDA_CONSTRUCCION (ronda 5)(cartaConstruir 10))
)

;HECHOS SIMPLES
(deffacts hechos-simples-iniciales
(EsTurnoDe 1)
(semaforoLoseta No);semaforo
(semaforoInteres No)
(prestamo 1 0 No);atributos --> jugador, cantidadPrestamos y interesPagado
(prestamo 2 0 No);atributos --> jugador, cantidadPrestamos y interesPagado
(eleccionOferta NULL);-------PARA PRUEBA ¡¡¡¡¡QUITAR!!!---------------
(pagoComida 1 0 No);semaforo para pagar comida J1
(pagoComida 2 0 No);semaforo para pagar comida J2
(pagoCosecha 1 No);semaforo para pagar cosecha J1
(pagoCosecha 2 No);semaforo para pagar cosecha J2
(recurso-pago NULL);semafro para el pago de comida con recurso
(restaurarBonus No)
(restaurarComida No)
(rondaActual 1)
(rondaFinal 5)
(primera-carta-mazo-comun 1)
(siguiente-carta-mazo-comun 1 2)
(siguiente-carta-mazo-comun 2 3)
(siguiente-carta-mazo-comun 3 4)
(siguiente-carta-mazo-comun 5 6)
)


;                    ▒█▀▀▀ ░█▀▀█ ▒█▀▀▀█ ▒█▀▀▀ 　 ▄█░ 
;                    ▒█▀▀▀ ▒█▄▄█ ░▀▀▀▄▄ ▒█▀▀▀ 　 ░█░ 
;                    ▒█░░░ ▒█░▒█ ▒█▄▄▄█ ▒█▄▄▄ 　 ▄█▄

;El jugador realiza el suministro y se desplaza a la siguiente loseta perteneciente a esa ronda
(defrule accion-oferta-normal
    ?semaforo <- (semaforoLoseta No)
    ?turno <- (EsTurnoDe ?jugador)
    ?losetaJugador <- (object (is-a JUGADOR_LOSETA) (jugador ?jugador)(losetaActual ?loseta))
    ?eleccionOferta <- (eleccionOferta NULL);***************************************
    (object (is-a RECURSO_LOSETA) (loseta ?loseta)(recurso ?recurso1)(cantidadRecurso ?cantidad1))
    (object (is-a RECURSO_LOSETA) (loseta ?loseta)(recurso ?recurso2)(cantidadRecurso ?cantidad2))
    (test (neq ?recurso1 ?recurso2))
    (object (is-a LOSETA) (id ?loseta)(interes ?interes));Miramos si la loseta tiene interés
    ?semaforoInteres <- (semaforoInteres ?)
    ?oferta1 <- (object (is-a ZONA_OFERTA) (nombre ?recurso1)(cantidad ?cantidadOferta1))
    ?oferta2 <- (object (is-a ZONA_OFERTA) (nombre ?recurso2)(cantidad ?cantidadOferta2))
    =>
    (retract ?eleccionOferta);***************************************
    (assert (eleccionOferta ?recurso1));***************************************
    (retract ?semaforo)
    (assert (semaforoLoseta Si))
    (retract ?semaforoInteres)
    (assert (semaforoInteres ?interes));semaforo interes
    (modify-instance ?oferta1 (cantidad (+ ?cantidadOferta1 ?cantidad1)))
    (modify-instance ?oferta2 (cantidad (+ ?cantidadOferta2 ?cantidad2)))
    (printout t "El jugador " ?jugador " realiza la accion de suministro en la oferta de " ?recurso1 " y " ?recurso2 crlf)
)

(defrule interes-loseta-dinero
    ?semaforoInteres <- (semaforoInteres Si)
    ?prestamo <- (prestamo ?jugadorPrestamo ?cantidadPrestamos No)
    ?jugador <- (object (is-a JUGADOR) (id ?jugadorPrestamo)(dinero ?dinero))
    (test (> ?dinero 0))
    =>
    (retract ?prestamo)
    (assert (prestamo ?jugadorPrestamo ?cantidadPrestamos Si))
    (modify-instance ?jugador (dinero (- ?dinero 1)));
    (printout t "El jugador " ?jugadorPrestamo " paga intereses por sus prestamos. Dinero actual :  " (- ?dinero 1) crlf)
)

(defrule interes-loseta-prestamo
    ?semaforoInteres <- (semaforoInteres Si)
    ?prestamo <- (prestamo ?jugadorPrestamo ?cantidadPrestamos No)
    ?jugador <- (object (is-a JUGADOR) (id ?jugadorPrestamo)(dinero ?dinero))
    (test (<= ?dinero 0))
    =>
    (retract ?prestamo)
    (assert (prestamo ?jugadorPrestamo (+ ?cantidadPrestamos 1) Si))
    (modify-instance ?jugador (dinero (+ ?dinero 3)));Pide el prestamo le da 4 francos pero paga 1 de interés
    (printout t "El jugador " ?jugadorPrestamo " pide un prestamo para pagar sus interes. Dinero actual :  " (+ ?dinero 3) crlf)
)


;                ▒█▀▀▀ ░█▀▀█ ▒█▀▀▀█ ▒█▀▀▀ 　 █▀█ 
;                ▒█▀▀▀ ▒█▄▄█ ░▀▀▀▄▄ ▒█▀▀▀ 　 ░▄▀ 
;                ▒█░░░ ▒█░▒█ ▒█▄▄▄█ ▒█▄▄▄ 　 █▄▄

;====================================================================
;            OPCION 1 : TOMAR BIENES DE LA OFERTA
;====================================================================

;HACER REGLA ESTRATÉGICA PARA LA ELEGIR LA ZONA DE OFERTA A TOMAR LOS RECURSOS

(defrule tomar-bienes-oferta-recursos
    ?turno <- (EsTurnoDe ?jugadorTurno)
    ?eleccionOferta <- (eleccionOferta ?ofertaElegida);Funciona de semáforo para esta regla
    ?oferta <- (object (is-a ZONA_OFERTA) (nombre ?ofertaElegida)(cantidad ?cantidadOferta))
    (test (> ?cantidadOferta 0))
    (test (neq ?ofertaElegida FRANCOS))
    ?recursoJugador <- (object (is-a RECURSO_JUGADOR) (jugador ?jugadorTurno)(tipoRecurso ?ofertaElegida)(cantidadRecurso ?cantidad))
    =>
    (retract ?eleccionOferta)
    (assert (eleccionOferta NULL))
    (modify-instance ?oferta (cantidad 0))
    (modify-instance ?recursoJugador (cantidadRecurso (+ ?cantidad ?cantidadOferta)))
    (printout t "El jugador " ?jugadorTurno " toma "?cantidadOferta " bienes de la oferta de "?ofertaElegida crlf)
    ;HABRIA QUE CAMBIAR EL TURNO YA?
    (assert (eleccionEdificio 21));*********************************************************
)

(defrule tomar-bienes-oferta-francos
    ?turno <- (EsTurnoDe ?jugadorTurno)
    ?eleccionOferta <- (eleccionOferta ?ofertaElegida);Funciona de semáforo para esta regla
    ?oferta <- (object (is-a ZONA_OFERTA) (nombre ?ofertaElegida)(cantidad ?cantidadOferta))
    (test (> ?cantidadOferta 0))
    (test (eq ?ofertaElegida FRANCOS))
    ?jugador <- (object (is-a JUGADOR) (id ?jugadorTurno)(dinero ?dinero))
    =>
    (retract ?eleccionOferta)
    (assert (eleccionOferta NULL))
    (modify-instance ?oferta (cantidad 0))
    (modify-instance ?jugador (dinero (+ ?dinero ?cantidadOferta)))
    (printout t "El jugador " ?jugadorTurno " toma "?cantidadOferta " francos de la oferta de "?ofertaElegida crlf)
    ;HABRIA QUE CAMBIAR EL TURNO YA?
)

;====================================================================
;            OPCION 2 : MOVER PERSONA PARA USAR EDIFICIO
;====================================================================

;HACER REGLA ESTRATEGICA PARA DECIDIR A QUÉ EDIFICIO DESPLAZAR EL TRABAJADOR
; (defrule eleccion-carta-trabajo
;     ?turno <- (EsTurnoDe ?jugadorTurno)
; )

(defrule mover-trabajador-edificio
    (EsTurnoDe ?jugadorTurno)
    ?semaforoPago <- (pagoComida ?jugadorTurno ? ?finDeRonda)
    ?eleccionEdificio <- (eleccionEdificio ?idEdificio)
    ?trabajoEn <- (object (is-a TRABAJA_EN) (trabajador ?jugadorTurno)(carta ?))
    ?edificio <- (object (is-a CARTA_EDIFICIO) (id ?idEdificio)(tipo ?nombreEdificio)(costeCompra ?)(valor ?)(desplegada Si)(construido Si)(costeUso ?costeUso))
    =>
    ;El jugador debe pagar los coste de entrada al edificio (con comida o con dinero)
    ;lanzo un semaforo para pagar la comida. Se indica la cantidad a pagar
    (retract ?semaforoPago)
    (assert (pagoComida ?jugadorTurno ?costeUso ?finDeRonda))
    (retract ?eleccionEdificio)
    (modify-instance ?trabajoEn (carta ?idEdificio))
    (printout t "El trabajador del jugador " ?jugadorTurno " se mueve al edificio "?idEdificio crlf)
    (printout t "El jugador " ?jugadorTurno " debe pagar "?costeUso " de comida por el uso del edificio" crlf)
)

;El barco solo te aporta comida al final de cada ronda, no se puede mover a trabajadores a él
; (defrule mover-trabajador-barco
;     (EsTurnoDe ?jugadorTurno)
;     ?semaforoPago <- (pagoComida ?jugadorTurno ? ?finDeRonda)
;     ?eleccionBarco <- (eleccionBarco ?idBarco)
;     ?trabajoEn <- (object (is-a TRABAJA_EN) (trabajador ?jugadorTurno)(carta ?))
;     ?barco <- (object (is-a CARTA_BARCO) (id ?idBarco)(tipo ?nombreBarco)(costeCompra ?)(valor ?)(desplegada Si)(construido Si)(recompensaComida ?recompensaComida))
;     =>
;     (retract ?semaforoPago)
;     (assert (pagoComida ?jugadorTurno 0 ?finDeRonda));No tiene coste de uso
;     (retract ?eleccionBarco)
;     (modify-instance ?trabajoEn (carta ?idBarco))
;     (printout t "El trabajador del jugador " ?jugadorTurno " se mueve al barco de " ?nombreBarco crlf)
; )

;Elijo los recursos para pagar la comida
(defrule almacenar-recursos-pagoComida
    ?recursoPago <- (recurso-pago ?)
    (pagoComida ?jugadorTurno ?cantidadPagar ?)
    ?recursoComida <- (object (is-a RECURSO_COMIDA) (tipo ?tipoRecurso)(valor ?)(comida ?comida)(comprobado No));Cojo recursos que no hay comprobado 
    (object (is-a RECURSO_JUGADOR) (jugador ?jugadorTurno)(tipoRecurso ?tipoRecurso)(cantidadRecurso ?cantidadRecurso))
    (test (> ?cantidadPagar 0));Cantidad pagar todavía mayor que 0
    =>
    (modify-instance ?recursoComida (comprobado Si))
    (retract ?recursoPago)
    (assert (recurso-pago ?tipoRecurso));Almaceno el recurso a con el que voy a probar a pagar en la BH
    (printout t "El jugador " ?jugadorTurno " intenta pagar la comida con el recurso " ?tipoRecurso crlf)
)

;El jugador le paga la comida al otro jugador(propietario) en recursos
(defrule pago-comida-recursos-jugador
    (EsTurnoDe ?jugadorTurno)
    (object (is-a TRABAJA_EN) (trabajador ?jugadorTurno)(carta ?edificioTrabajador))
    (object (is-a PROPIETARIO_CARTA) (propietario ?propietario)(carta ?edificioTrabajador))
    ?semaforoPago <- (pagoComida ?jugadorTurno ?cantidadPagar ?finDeRonda)
    ?semaforoRecursoPago <- (recurso-pago ?recursoPago)
    (object (is-a RECURSO_COMIDA) (tipo ?recursoPago)(valor ?)(comida ?comida)(comprobado Si))
    ?recursoJugador <- (object (is-a RECURSO_JUGADOR) (jugador ?jugadorTurno)(tipoRecurso ?recursoPago)(cantidadRecurso ?cantidadRecurso))
    ?recursoPropietario <- (object (is-a RECURSO_JUGADOR) (jugador ?propietario)(tipoRecurso ?recursoPago)(cantidadRecurso ?cantidadRecursoPropietario))
    (test (> ?cantidadRecurso 0))
    =>
    (bind ?cantidadRecursoDisminucion (max (div ?cantidadPagar ?comida) 1));Cantidad de recursos necesarios para pagar toda la deuda
    (modify-instance ?recursoJugador (cantidadRecurso (max (- ?cantidadRecurso ?cantidadRecursoDisminucion) 0)))
    (bind ?cantidadRecursoPago (min ?cantidadRecurso ?cantidadRecursoDisminucion));La cantidad de recursos que realmente pago
    (modify-instance ?recursoPropietario (cantidadRecurso (+ ?cantidadRecursoPropietario ?cantidadRecursoPago)))
    (retract ?semaforoRecursoPago)
    (assert (recurso-pago NULL));Ya he pagado con el recurso seleccionado
    (retract ?semaforoPago)
    (assert (pagoComida ?jugadorTurno (max (- ?cantidadPagar (* ?cantidadRecursoPago ?comida)) 0) ?finDeRonda))
    (printout t "El jugador " ?jugadorTurno " paga la comida al jugador " ?propietario " con el recurso " ?recursoPago crlf)
    (printout t "Cantidad restante de pago " (max (- ?cantidadPagar (* ?cantidadRecursoPago ?comida)) 0) crlf)
)

;El jugador le paga la comida al tablero(propietario) en recursos
(defrule pago-comida-recursos-tablero
    ?semaforoPago <- (pagoComida ?jugadorTurno ?cantidadPagar ?finDeRonda)
    (object (is-a TRABAJA_EN) (trabajador ?jugadorTurno)(carta ?edificioTrabajador))
    (not (object (is-a PROPIETARIO_CARTA) (propietario ?)(carta ?edificioTrabajador)));No haya propietario--> tablero posee la carta
    ?semaforoRecursoPago <- (recurso-pago ?recursoPago)
    (object (is-a RECURSO_COMIDA) (tipo ?recursoPago)(valor ?)(comida ?comida)(comprobado Si))
    ?recursoJugador <- (object (is-a RECURSO_JUGADOR) (jugador ?jugadorTurno)(tipoRecurso ?recursoPago)(cantidadRecurso ?cantidadRecurso))
    (test (> ?cantidadRecurso 0))
    (test (> ?cantidadPagar 0))
    =>
    ;Miramos cuantos recursos va a utilizar para pagar
    (bind ?cantidadRecursoDisminucion (max (div ?cantidadPagar ?comida) 1));Cantidad de recursos necesarios para pagar toda la deuda
    (modify-instance ?recursoJugador (cantidadRecurso (max (- ?cantidadRecurso ?cantidadRecursoDisminucion) 0)))
    (bind ?cantidadRecursoPago (min ?cantidadRecurso ?cantidadRecursoDisminucion));La cantidad de recursos que realmente pago
    (retract ?semaforoRecursoPago)
    (assert (recurso-pago NULL));Ya he pagado con el recurso seleccionado
    (retract ?semaforoPago)
    (assert (pagoComida ?jugadorTurno (max (- ?cantidadPagar (* ?cantidadRecursoPago ?comida)) 0) ?finDeRonda))
    (printout t "El jugador " ?jugadorTurno " paga la comida con el recurso " ?recursoPago crlf)
    (printout t "Cantidad restante de pago " (max (- ?cantidadPagar (* ?cantidadRecursoPago ?comida)) 0) crlf)
)

;Priorizaría pagar con recursos y si no tiene recurso pagara con dinero
(defrule pago-comida-dinero-jugador
    (EsTurnoDe ?jugadorTurno)
    (object (is-a TRABAJA_EN) (trabajador ?jugadorTurno)(carta ?edificioTrabajador))
    (object (is-a PROPIETARIO_CARTA) (propietario ?idPropietario)(carta ?edificioTrabajador))
    (not (object (is-a RECURSO_COMIDA) (tipo ?)(valor ?)(comida ?)(comprobado No)))
    ?semaforoPago <- (pagoComida ?jugadorTurno ?cantidadPagar ?finDeRonda)
    ?jugador <- (object (is-a JUGADOR) (id ?jugadorTurno)(dinero ?dineroJugador))
    ?propietario <- (object (is-a JUGADOR) (id ?idPropietario)(dinero ?dineroPropietario))
    (test (> ?cantidadPagar 0));Cantidad pagar todavía mayor que 0
    (test (>= ?dineroJugador ?cantidadPagar));Puedo pagar con el dinero que tengo
    =>
    (retract ?semaforoPago)
    (assert (pagoComida ?jugadorTurno 0 ?finDeRonda))
    (modify-instance ?jugador (dinero (- ?dineroJugador ?cantidadPagar)))
    (modify-instance ?propietario (dinero (+ ?dineroPropietario ?cantidadPagar)))
    (printout t "El jugador " ?jugadorTurno " paga al jugador " ?idPropietario " con " ?cantidadPagar " franco/francos por la comida" crlf)
)

(defrule pago-comida-dinero-tablero
    (object (is-a TRABAJA_EN) (trabajador ?jugadorTurno)(carta ?edificioTrabajador))
    (not (object (is-a PROPIETARIO_CARTA) (propietario ?)(carta ?edificioTrabajador)));No haya propietario--> tablero posee la carta
    (not (object (is-a RECURSO_COMIDA) (tipo ?)(valor ?)(comida ?)(comprobado No)))
    ?semaforoPago <- (pagoComida ?jugadorTurno ?cantidadPagar ?finDeRonda)
    ?jugador <- (object (is-a JUGADOR) (id ?jugadorTurno)(dinero ?dineroJugador))
    (test (> ?cantidadPagar 0));Cantidad pagar todavía mayor que 0
    (test (>= ?dineroJugador ?cantidadPagar));Puedo pagar con el dinero que tengo
    =>
    (retract ?semaforoPago)
    (assert (pagoComida ?jugadorTurno 0 ?finDeRonda))
    (modify-instance ?jugador (dinero (- ?dineroJugador ?cantidadPagar)))
    (printout t "El jugador " ?jugadorTurno " paga al tablero con " ?cantidadPagar " franco/francos por la comida" crlf)
)

(defrule comprobacion-restaurar-comida
    (EsTurnoDe ?jugadorTurno)
    ?restaurarComida <- (restaurarComida No)
    (not (object (is-a RECURSO_COMIDA) (tipo ?)(valor ?)(comida ?)(comprobado No)))
    (pagoComida ?jugadorTurno 0 ?)
    =>
    (retract ?restaurarComida)
    (assert (restaurarComida Si))
)

(defrule restaurar-comida
    (restaurarComida Si)
    ?recursoComida <- (object (is-a RECURSO_COMIDA) (tipo ?recurso)(valor ?)(comida ?)(comprobado Si))
    =>
    (modify-instance ?recursoComida (comprobado No))
    (printout t "Restaurando recurso " ?recurso " ..............." crlf)
)

;Esta regla se aplica al pago de la comida en el fin de ronda
(defrule pago-comida-dinero-prestamo
    (not (object (is-a RECURSO_COMIDA) (tipo ?)(valor ?)(comida ?)(comprobado No)))
    ?semaforoPago <- (pagoComida ?jugadorTurno ?cantidadPagar Si);Fuerza a que venga de la regla de fin de ronda
    ?prestamos <- (prestamo ?jugadorTurno ?cantidadPrestamos ?interes)
    ?jugador <- (object (is-a JUGADOR) (id ?jugadorTurno)(dinero ?dineroJugador))
    (test (> ?cantidadPagar 0));Cantidad pagar todavía mayor que 0
    (test (< ?dineroJugador ?cantidadPagar));No puedo pagar con el dinero que tengo
    =>
    (retract ?semaforoPago)
    (assert (pagoComida ?jugadorTurno 0 Si))
    (retract ?prestamos)
    (assert (prestamo ?jugadorTurno (+ ?cantidadPrestamos 1) ?interes))
    (bind ?nuevoDinero (+ ?dineroJugador 4))
    (modify-instance ?jugador (dinero (- ?nuevoDinero ?cantidadPagar)))
    (printout t "El jugador " ?jugadorTurno " pide un prestamo para pagar la comida" crlf)
    (printout t "El jugador " ?jugadorTurno " paga " ?cantidadPagar " francos" crlf)
    (printout t "Dinero restante del jugador: " (- ?nuevoDinero ?cantidadPagar) " franco/francos" crlf)
)

                        ;   +-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+
                        ;   |A|C|C|I|O|N|E|S| |E|D|I|F|I|C|I|O|S|
                        ;   +-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+

(defrule construir-edificio
    ?turno <- (EsTurnoDe ?jugadorTurno)
    (pagoComida ?jugadorTurno 0 No);Se haya pagado ya por su uso
    (object (is-a TRABAJA_EN) (trabajador ?jugadorTurno)(carta ?cartaTrabajo))
    (object (is-a CARTA_EDIFICIO) (id ?cartaTrabajo)(tipo CONSTRUCTORA)(costeCompra ?)(valor ?valor)(construido Si)(costeUso ?))
    (primera-carta-mazo-comun ?cartaConstruir)
    ?costeContruccion <- (object (is-a COSTE_CONSTRUCCION_EDIFICIO) (edificio ?cartaConstruir)(recurso ?recursoConstruir)(cantidadRecurso ?cantidadConstruir))
    ?recursoJugador <- (object (is-a RECURSO_JUGADOR) (jugador ?jugadorTurno)(tipoRecurso ?recursoConstruir)(cantidadRecurso ?cantidadRecurso))
    ?edificio <- (object (is-a CARTA_EDIFICIO) (id ?cartaConstruir)(tipo ?nombreEdificio)(costeCompra ?)(valor ?)(desplegada Si)(construido No)(costeUso ?))
    (test (>= ?cantidadRecurso ?cantidadConstruir));Esto debería sobrar --> ya debería estar comprobado
    =>
    (unmake-instance ?costeContruccion)
    (modify-instance ?recursoJugador (cantidadRecurso (- ?cantidadRecurso ?cantidadConstruir)))
    (printout t "Construyendo " ?nombreEdificio " con " ?cantidadConstruir " de " ?recursoConstruir crlf)
)


;Se supone que si has elegido moverte a la CONSTRUCTORA ES PORQUE TIENE LOS RECURSOS PARA CONSTRUIR
(defrule edificio-construido
    ?turno <- (EsTurnoDe ?jugadorTurno)
    (object (is-a TRABAJA_EN) (trabajador ?jugadorTurno)(carta ?cartaTrabajo))
    (object (is-a CARTA_EDIFICIO) (id ?cartaTrabajo)(tipo CONSTRUCTORA)(costeCompra ?)(valor ?valor)(construido Si)(costeUso ?))
    ?cartaMazo <- (primera-carta-mazo-comun ?cartaConstruir);Se coge la primera carta del mazo
    ?siguienteCartaMazo <- (siguiente-carta-mazo-comun ?cartaConstruir ?siguienteCarta)
    (not (object (is-a COSTE_CONSTRUCCION_EDIFICIO) (edificio ?cartaConstruir)(recurso ?)(cantidadRecurso ?)));Se comprueba que se haya terminado construir
    ?edificio <- (object (is-a CARTA_EDIFICIO) (id ?cartaConstruir)(tipo ?nombreEdificio)(costeCompra ?)(valor ?)(desplegada Si)(construido No)(costeUso ?))
    =>
    (assert (cambioTurno Si));*********************************************************
    (retract ?cartaMazo)
    (assert (primera-carta-mazo-comun ?siguienteCarta))
    (retract ?siguienteCartaMazo)
    (modify-instance ?edificio (construido Si))
    (make-instance of PROPIETARIO_CARTA (propietario ?jugadorTurno)(carta ?cartaConstruir));Se asigna al jugador como propietario del edificio
    (printout t "El jugador " ?jugadorTurno " ha construido el edificio " ?nombreEdificio crlf)
)

;Regla estratégica que decida el barco a construir
(defrule construir-barco
    (EsTurnoDe ?jugadorTurno)
    (pagoComida ?jugadorTurno 0 No);Se haya pagado ya por el uso del ASERRADERO
    (eleccionBarco ?idBarco);semaforo lanzado por la regla estrategica para elegir el barco a construir
    (object (is-a TRABAJA_EN) (trabajador ?jugadorTurno)(carta ?cartaTrabajo))
    (object (is-a CARTA_EDIFICIO) (id ?cartaTrabajo)(tipo ASTILLERO)(costeCompra ?)(valor ?valor)(desplegada Si)(construido Si)(costeUso ?))
    ?costeConstruccion <- (object (is-a COSTE_CONSTRUCCION_BARCO) (barco ?idBarco)(recurso ?recursoConstruir)(cantidadRecurso ?cantidadConstruir)(energiaNecesaria ?energia))
    ?recursoJugador <- (object (is-a RECURSO_JUGADOR) (jugador ?jugadorTurno)(tipoRecurso ?recursoConstruir)(cantidadRecurso ?cantidadRecurso))
    (object (is-a CARTA_BARCO) (id ?idBarco)(tipo ?nombreBarco)(costeCompra ?)(valor ?)(desplegada Si)(construido No)(recompensaComida ?))
    (test (>= ?cantidadRecurso ?cantidadConstruir))
    =>
    (assert (energiaConstruir ?energia))
    (unmake-instance ?costeConstruccion)
    (modify-instance ?recursoJugador (cantidadRecurso (- ?cantidadRecurso ?cantidadConstruir)))
    (printout t "Construyendo " ?nombreBarco " con " ?cantidadConstruir " de " ?recursoConstruir crlf)
)

(defrule pago-energia
    (EsTurnoDe ?jugadorTurno)
    ?pagoEnergia <- (energiaConstruir ?cantidadEnergia)
    (object (is-a RECURSO_ENERGETICO) (tipo ?recursoEnergia)(valor ?)(energia ?aporteEnergetico))
    ?recursoJugador <- (object (is-a RECURSO_JUGADOR) (jugador ?jugadorTurno)(tipoRecurso ?recursoEnergia)(cantidadRecurso ?cantidadRecurso))
    (test (> ?cantidadEnergia 0))
    (test (> ?cantidadRecurso 0))
    =>
    (bind ?cantidadRecursoDisminucion (max (div ?cantidadEnergia ?aporteEnergetico) 1));Cantidad de recursos necesarios para saldar energia
    (modify-instance ?recursoJugador (cantidadRecurso (max (- ?cantidadRecurso ?cantidadRecursoDisminucion) 0)))
    (bind ?cantidadRecursoPago (min ?cantidadRecurso ?cantidadRecursoDisminucion));La cantidad de recursos que realmente pago
    (retract ?pagoEnergia)
    (assert (energiaConstruir (max (- ?cantidadEnergia (* ?cantidadRecursoPago ?aporteEnergetico)) 0)))
    (printout t "El jugador " ?jugadorTurno " utiliza el recurso " ?recursoEnergia " para obtener energia y construir el barco" crlf)
    (printout t "Cantidad de energia restante : " (max (- ?cantidadEnergia (* ?cantidadRecursoPago ?aporteEnergetico)) 0) crlf)
)

(defrule barco-construido
    (EsTurnoDe ?jugadorTurno)
    ?semaforoBarco <- (eleccionBarco ?idBarco)
    ?pagoEnergia <- (energiaConstruir ?cantidadEnergia)
    (not (object (is-a COSTE_CONSTRUCCION_BARCO) (barco ?idBarco)(recurso ?)(cantidadRecurso ?)(energiaNecesaria ?)))
    ?barco <- (object (is-a CARTA_BARCO) (id ?idBarco)(tipo ?nombreBarco)(costeCompra ?)(valor ?)(desplegada Si)(construido No)(recompensaComida ?))
    (test (= ?cantidadEnergia 0))
    =>
    (retract ?semaforoBarco)
    (retract ?pagoEnergia)
    (modify-instance ?barco (construido Si))
    (make-instance of PROPIETARIO_CARTA (propietario ?jugadorTurno)(carta ?idBarco));Se asigna al jugador como propietario del barco
    (printout t "El jugador " ?jugadorTurno " ha construido el barco de " ?nombreBarco crlf)
)

;----------------------Te aporta recursos a cambio de nada--------------------------------------------------------------------

(defrule accion-edificio-null-recurso
    ?turno <- (EsTurnoDe ?jugadorTurno)
    (object (is-a TRABAJA_EN) (trabajador ?jugadorTurno)(carta ?cartaTrabajo))
    ?bonusEdificio <- (object (is-a BONUS_USO_EDIFICIO) (carta ?cartaTrabajo)(recurso ?recursoBonus)(recursoRecompensa ?recursoRecompensa)(cantidadRecompensa ?cantidadRecompensa)(bonusAplicado No))
    ?recursoJugador <- (object (is-a RECURSO_JUGADOR) (jugador ?jugadorTurno)(tipoRecurso ?recursoRecompensa)(cantidadRecurso ?cantidadRecursoJugador))
    (test (eq ?recursoBonus NULL))
    =>
    (modify-instance ?bonusEdificio (bonusAplicado Si))
    (modify-instance ?recursoJugador (cantidadRecurso (+ ?cantidadRecursoJugador ?cantidadRecompensa)))
    (printout t "Trabajando en el edificio........." crlf)
    (printout t "El jugador " ?jugadorTurno " recibe " ?cantidadRecompensa " de " ?recursoBonus crlf)
)


;Si es del tipo 2 recursos por 4 de dinero, cambiar del atributo cantidad de recompensa a la mitad de dinero o a su parte proporcional
;Cada vez que se ejecute la regla se le suma al jugador la cantidad de dinero especificada, luego cambiarlo de la instancia
;------------------------Te aporta dinero a cambio de recursos------------------------------------------------------------------

(defrule accion-edificio-recursos-dinero
    ?turno <- (EsTurnoDe ?jugadorTurno)
    (object (is-a TRABAJA_EN) (trabajador ?jugadorTurno)(carta ?cartaTrabajo))
    ?bonusEdificio <- (object (is-a BONUS_USO_EDIFICIO) (carta ?cartaTrabajo)(recurso ?recursoBonus)(recursoRecompensa ?recursoRecompensa)(cantidadRecompensa ?cantidadRecompensa)(bonusAplicado No))
    ?jugador <- (object (is-a JUGADOR) (id ?jugadorTurno)(dinero ?dineroJugador))
    ?recursoJugador <- (object (is-a RECURSO_JUGADOR) (jugador ?jugadorTurno)(tipoRecurso ?recursoBonus)(cantidadRecurso ?cantidadRecursoJugador))
    (test (eq ?recursoRecompensa FRANCO))
    (test (> ?cantidadRecursoJugador 0))
    =>
    (modify-instance ?bonusEdificio (bonusAplicado Si))
    (modify-instance ?recursoJugador (cantidadRecurso (- ?cantidadRecursoJugador 1)))
    (modify-instance ?jugador (dinero (+ ?dineroJugador ?cantidadRecompensa)))
    (printout t "Trabajando en el edificio........." crlf)
    (printout t "El jugador " ?jugadorTurno " cambia 1 " ?recursoBonus " por " ?cantidadRecompensa " " ?recursoRecompensa crlf)
)

;------------------------Te aporta recursos a cambio de recursos------------------------------------------------------------------

(defrule accion-edificio-recursos-recursos
    ?turno <- (EsTurnoDe ?jugadorTurno)
    (object (is-a TRABAJA_EN) (trabajador ?jugadorTurno)(carta ?cartaTrabajo))
    ?bonusEdificio <- (object (is-a BONUS_USO_EDIFICIO) (carta ?cartaTrabajo)(recurso ?recursoBonus)(recursoRecompensa ?recursoRecompensa)(cantidadRecompensa ?cantidadRecompensa)(bonusAplicado No))
    ?jugador <- (object (is-a JUGADOR) (id ?jugadorTurno)(dinero ?dineroJugador))
    ?recursoJugadorAportar <- (object (is-a RECURSO_JUGADOR) (jugador ?jugadorTurno)(tipoRecurso ?recursoBonus)(cantidadRecurso ?cantidadRecursoADisminuir))
    ?recursoJugadorRecibir <- (object (is-a RECURSO_JUGADOR) (jugador ?jugadorTurno)(tipoRecurso ?recursoRecompensa)(cantidadRecurso ?cantidadRecursoAAumentar))
    (test (> ?cantidadRecursoADisminuir 0))
    =>
    (modify-instance ?bonusEdificio (bonusAplicado Si))
    (modify-instance ?recursoJugadorAportar (cantidadRecurso (- ?cantidadRecursoADisminuir 1)))
    (modify-instance ?recursoJugadorRecibir (cantidadRecurso (+ ?cantidadRecursoAAumentar  ?cantidadRecompensa)))
    (printout t "Trabajando en el edificio........." crlf)
    (printout t "El jugador " ?jugadorTurno " cambia 1 de " ?recursoBonus " por " ?cantidadRecompensa " de " ?recursoRecompensa crlf)
)

(defrule accion-edificio-terminada
    (EsTurnoDe ?jugadorTurno)
    ?restaurarBonus <- (restaurarBonus ?)
    (pagoComida ?jugadorTurno 0 No);Se haya pagado ya por su uso
    (object (is-a TRABAJA_EN) (trabajador ?jugadorTurno)(carta ?cartaTrabajo))
    (test (<> ?cartaTrabajo 20));No esté en la constructora
    (test (<> ?cartaTrabajo 21));No esté en la constructora
    (test (<> ?cartaTrabajo 7));No esté en el Aserradero
    (test (<> ?cartaTrabajo 0));Para que no entre en la situacion inicial
    (not (object (is-a BONUS_USO_EDIFICIO) (carta ?cartaTrabajo)(recurso ?)(recursoRecompensa ?)(cantidadRecompensa ?)(bonusAplicado No)))
    =>
    (retract ?restaurarBonus)
    (assert (restaurarBonus Si))
)

(defrule restaurar-bonus-edificios 
    (restaurarBonus Si)
    ?bonusEdificio <- (object (is-a BONUS_USO_EDIFICIO) (carta ?)(recurso ?)(recursoRecompensa ?)(cantidadRecompensa ?)(bonusAplicado Si))
    =>
    (modify-instance ?bonusEdificio (bonusAplicado No))
)

;====================================================================
;            OPCIONAL : COMPRAR O VENDER
;====================================================================

;Regla estratégica que te diga qué edificio comprar. La regla tiene que si es rentable comprar un edificio
;Si tienes más dinero de x cantidad, seguramente sea rentable. Como la vida misma
;El costo de compra de un edificio es el max(valor,costeCompra)

;Sirve para barco o para comprar un edificio
(defrule accion-comprar-carta-jugadorPropietario
    ?turno <- (EsTurnoDe ?jugadorTurno)
    ?jugador <- (object (is-a JUGADOR) (id ?jugadorTurno)(dinero ?dineroJugador))
    ?cartaComprar <- (cartaComprar ?idCarta ?costeCompra);semaforo lanzado por la regla estratégica
    ?relacionPropietario <- (object (is-a PROPIETARIO_CARTA) (propietario ?idPropietario)(carta ?idCarta))
    ?propietario <- (object (is-a JUGADOR) (id ?idPropietario)(dinero ?dineroPropietario))
    (test (>= ?dineroJugador ?costeCompra))
    =>
    (retract ?cartaComprar)
    (modify-instance ?jugador (dinero (- ?dineroJugador ?costeCompra)))
    (modify-instance ?propietario (dinero (+ ?dineroPropietario ?costeCompra)))
    (unmake-instance ?relacionPropietario)
    (make-instance of PROPIETARIO_CARTA (propietario ?jugadorTurno)(carta ?idCarta))
    (printout t "El jugador " ?jugadorTurno " compra la carta con id " ?idCarta " al jugador " ?idPropietario " por " ?costeCompra " FRANCOS" crlf)
)

(defrule accion-comprar-carta-tablero
    ?turno <- (EsTurnoDe ?jugadorTurno)
    ?jugador <- (object (is-a JUGADOR) (id ?jugadorTurno)(dinero ?dineroJugador))
    ?cartaComprar <- (cartaComprar ?idCarta ?costeCompra);semaforo lanzado por la regla estratégica
    (not (object (is-a PROPIETARIO_CARTA) (propietario ?)(carta ?idCarta)))
    (test (>= ?dineroJugador ?costeCompra))
    =>
    (retract ?cartaComprar)
    (modify-instance ?jugador (dinero (- ?dineroJugador ?costeCompra)))
    (make-instance of PROPIETARIO_CARTA (propietario ?jugadorTurno)(carta ?idCarta))
    (printout t "El jugador " ?jugadorTurno " compra la carta con id  " ?idCarta " al tablero por " ?costeCompra " FRANCOS" crlf)
)

;Regla estrategica que decida que edificio tiene que vender el jugador de los que tiene
;Esta regla pasa el id del edificio y su valor de venta 
;Los jugadores que trabajan en los edificios se quedan en los edificios
(defrule accion-vender-carta
    ?turno <- (EsTurnoDe ?jugadorTurno)
    ?jugador <- (object (is-a JUGADOR) (id ?jugadorTurno)(dinero ?dineroJugador))
    ?cartaVender <- (cartaVender ?idCarta ?valorVenta)
    ?relacionPropietario <- (object (is-a PROPIETARIO_CARTA) (propietario ?jugadorTurno)(carta ?idCarta))
    =>
    (retract ?cartaVender)
    (unmake-instance ?relacionPropietario)
    (modify-instance ?jugador (dinero (+ ?dineroJugador ?valorVenta)))
    (printout t "El jugador " ?jugadorTurno " vende la carta con id " ?idCarta " al tablero por " ?valorVenta " FRANCOS" crlf)
)

;Cambiamos el turno y lanzamos semaforos correspondientes para resetear valores para el siguiente
(defrule cambio-turno
    ?turno <- (EsTurnoDe ?jugadorTurno)
    ?semaforoTurno <- (cambioTurno Si);semaforo cambio de turno, para que pueda ser invocado desde otras reglas
    (object (is-a JUGADOR) (id ?jugadorSiguienteTurno&~?jugadorTurno)(dinero ?))
    ?losetaJugador <- (object (is-a JUGADOR_LOSETA) (jugador ?jugadorTurno)(losetaActual ?loseta))
    ?trabajadorJugador <- (object (is-a TRABAJA_EN) (trabajador ?jugadorTurno)(carta ?))
    ?semaforoLoseta <- (semaforoLoseta ?);Hay que cambiarle el valor para que el siguiente jugador la pueda utilizar
    ?restaurarComida <- (restaurarComida ?)
    ?restaurarBonus <- (restaurarBonus ?)
    ?prestamoJugadorTurno <- (prestamo ?jugadorTurno ?cantidad ?)
    =>
    (modify-instance ?losetaJugador (losetaActual (mod (+ ?loseta 2) 7)));Actualizamos loseta jugadorActual
    (modify-instance ?trabajadorJugador (carta 0));Devolvemos al trabajador a su casa
    (retract ?semaforoTurno)
    (retract ?semaforoLoseta)
    (assert (semaforoLoseta No))
    (retract ?restaurarComida)
    (assert (restaurarComida No))
    (retract ?restaurarBonus)
    (assert (restaurarBonus No))
    (retract ?prestamoJugadorTurno)
    (assert (prestamo ?jugadorTurno ?cantidad No))
    (retract ?turno)
    (assert (EsTurnoDe ?jugadorSiguienteTurno))
    (printout t "Es turno del jugador " ?jugadorSiguienteTurno crlf)
)

;====================================================================
;                           FIN DE RONDA
;====================================================================

(defrule fin-de-ronda-edificioEspecial
    ?turno <- (EsTurnoDe ?jugadorTurno)
    (object (is-a JUGADOR) (id ?jugadorSiguienteTurno&~?jugadorTurno)(dinero ?))
    ?semaforoPagoComida1 <- (pagoComida ?jugadorTurno ? ?)
    ?semaforoPagoComida2 <- (pagoComida ?jugadorSiguienteTurno ? ?)
    ?semaforoPagoCosecha1 <- (pagoCosecha ?jugadorTurno ?)
    ?semaforoPagoCosecha2 <- (pagoCosecha ?jugadorSiguienteTurno ?)
    ?losetaJugador <- (object (is-a JUGADOR_LOSETA) (jugador ?jugadorTurno)(losetaActual ?loseta))
    (test (= ?loseta 7));El jugador esté en la última loseta de la ronda
    ?rondaActual <- (rondaActual ?ronda)
    ?cartaRonda <- (object (is-a CARTA_RONDA) (numRonda ?ronda)(pagoComida ?pagoComida)(cosecha ?cosecha))
    ?cartaRondaConstruir <- (object (is-a CARTA_RONDA_CONSTRUCCION) (ronda ?ronda)(cartaConstruir ?idCartaConstruir))
    ?cartaEdificio <- (object (is-a CARTA_EDIFICIO) (id ?idCartaConstruir)(tipo ?nombreEdificio)(costeCompra ?)(valor ?)(desplegada No)(construido No)(costeUso ?))
    =>
    (retract ?cartaRonda);Elimino la carta para que no vuelva a entrar

    (retract  ?semaforoPagoComida1)
    (retract  ?semaforoPagoComida2)
    (assert (pagoComida ?jugadorTurno ?pagoComida Si));Lanzo semaforos para pagar la comida J1
    (assert (pagoComida ?jugadorSiguienteTurno ?pagoComida Si));Lanzo semaforos para pagar la comida J2

    (retract  ?semaforoPagoCosecha1)
    (retract  ?semaforoPagoCosecha2)
    (assert (pagoCosecha ?jugadorTurno ?cosecha));Lanzo semaforos para pagar la cosecha J1
    (assert (pagoCosecha ?jugadorSiguienteTurno ?cosecha));Lanzo semaforos para pagar la cosecha J2

    (modify-instance ?cartaEdificio (desplegada Si)(Construida Si))
    (printout t "FIN DE LA RONDA " ?ronda crlf)
    (printout t "Se ha construido el edificio especial : " ?nombreEdificio crlf)
)

(defrule fin-de-ronda-Barco
    ?turno <- (EsTurnoDe ?jugadorTurno)
    (object (is-a JUGADOR) (id ?jugadorSiguienteTurno&~?jugadorTurno)(dinero ?))
    ?semaforoPagoComida1 <- (pagoComida ?jugadorTurno ? ?)
    ?semaforoPagoComida2 <- (pagoComida ?jugadorSiguienteTurno ? ?)
    ?semaforoPagoCosecha1 <- (pagoCosecha ?jugadorTurno ?)
    ?semaforoPagoCosecha2 <- (pagoCosecha ?jugadorSiguienteTurno ?)
    ?losetaJugador <- (object (is-a JUGADOR_LOSETA) (jugador ?jugadorTurno)(losetaActual ?loseta))
    (test (= ?loseta 7));El jugador esté en la última loseta de la ronda
    ?rondaActual <- (rondaActual ?ronda)
    ?cartaRonda <- (object (is-a CARTA_RONDA) (numRonda ?ronda)(pagoComida ?pagoComida)(cosecha ?cosecha))
    ?cartaRondaConstruir <- (object (is-a CARTA_RONDA_CONSTRUCCION) (ronda ?ronda)(cartaConstruir ?idCartaConstruir))
    ?cartaBarco <- (object (is-a CARTA_BARCO) (id ?idCartaConstruir)(tipo ?nombreBarco)(costeCompra ?)(valor ?)(desplegada No)(construido No)(recompensaComida ?))
    =>
    (retract ?cartaRonda);Elimino la carta para que no vuelva a entrar

    (retract  ?semaforoPagoComida1)
    (retract  ?semaforoPagoComida2)
    (assert (pagoComida ?jugadorTurno ?pagoComida Si));Lanzo semaforos para pagar la comida J1
    (assert (pagoComida ?jugadorSiguienteTurno ?pagoComida Si));Lanzo semaforos para pagar la comida J2

    (retract  ?semaforoPagoCosecha1)
    (retract  ?semaforoPagoCosecha2)
    (assert (pagoCosecha ?jugadorTurno ?cosecha));Lanzo semaforos para pagar la cosecha J1
    (assert (pagoCosecha ?jugadorSiguienteTurno ?cosecha));Lanzo semaforos para pagar la cosecha J2

    (modify-instance ?cartaBarco (desplegada Si)(Construida Si))
    (printout t "FIN DE LA RONDA " ?ronda crlf)
    (printout t "Se ha desplegado la carta Barco de " ?nombreBarco crlf)
)

;Comprueba si tengo una barco y me disminuye la comida en consonancia
(defrule disminucion-pago-comida
    ?pagoComida <- (pagoComida ?jugador ?cantidadPagar Si)
    (object (is-a PROPIETARIO_CARTA) (propietario ?jugador)(carta ?idCarta))
    (object (is-a CARTA_BARCO) (id ?idCarta)(tipo ?nombreCarta)(costeCompra ?)(valor ?)(desplegada Si)(construido Si)(recompensaComida ?disminucionComida))
    (test (> ?cantidadPagar 0))
    =>
    (retract ?pagoComida)
    (assert (pagoComida ?jugador (max (- ?cantidadPagar ?disminucionComida) 0) Si))
    (printout t "El jugador " ?jugador " es propietario de un " ?nombreCarta " luego se le ha disminuido la comida a pagar por el fin de ronda en " ?disminucionComida crlf)
    (printout t "Nueva cantidad de comida a pagar por el jugador " ?jugador " es de : " (max (- ?cantidadPagar ?disminucionComida) 0) crlf)
)

;Cada jugador con al menos [1 grano / 2 ganado] recibe [1 grano / 1 ganado] adicional
(defrule pago-cosecha
    ?semaforoPagoCosecha <- (pagoCosecha ?jugadorPago Si)
    ?recursoJugadorGrano <- (object (is-a RECURSO_JUGADOR) (tipoRecurso GRANO)(cantidadRecurso ?cantidadGrano))
    (test (>= ?cantidadGrano 1))
    ?recursoJugadorGanado <- (object (is-a RECURSO_JUGADOR) (tipoRecurso GANADO)(cantidadRecurso ?cantidadGanado))
    (test (>= ?cantidadGanado 2))
    =>
    (retract ?semaforoPagoCosecha)
    (assert (pagoCosecha ?jugadorPago No))
    (modify-instance ?recursoJugadorGrano (cantidadRecurso (+ ?cantidadGrano 1)))
    (modify-instance ?recursoJugadorGanado (cantidadRecurso (+ ?cantidadGanado 1)))
)

