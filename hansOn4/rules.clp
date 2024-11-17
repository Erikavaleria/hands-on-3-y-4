(deftemplate MAIN::smartphone
   (slot marca)
   (slot modelo)
   (slot color)
   (slot precio))

(deftemplate MAIN::computadora
   (slot marca)
   (slot modelo)
   (slot color)
   (slot precio))

(deftemplate MAIN::accesorio
   (slot nombre)
   (slot categoria)
   (slot precio))

(deftemplate MAIN::tarjeta-credito
   (slot banco)
   (slot grupo)
   (slot exp-date))

(deftemplate MAIN::vale
   (slot codigo)
   (slot valor)
   (slot fecha-expiracion))

(deftemplate MAIN::customer
   (slot customer-id)
   (multislot name)
   (multislot address)
   (slot phone))

(deftemplate MAIN::product
   (slot part-number)
   (slot name)
   (slot category)
   (slot price))

(deftemplate MAIN::order
   (slot order-number)
   (slot customer-id))

(deftemplate MAIN::line-item
   (slot order-number)
   (slot part-number)
   (slot customer-id)
   (slot quantity (default 1)))

(deftemplate MAIN::stock
   (slot part-number)
   (slot name)
   (slot category)
   (slot price)
   (slot stock))

(deffacts MAIN::smartphones
   (smartphone (marca apple) (modelo iPhone16) (color rojo) (precio 27000))
   (smartphone (marca samsung) (modelo GalaxyS21) (color negro) (precio 22000)))

(deffacts MAIN::computadoras
   (computadora (marca apple) (modelo macbookpro) (color gris) (precio 47000))
   (computadora (marca dell) (modelo XPS13) (color plata) (precio 35000)))

(deffacts MAIN::accesorios
   (accesorio (nombre USBMem) (categoria storage) (precio 199.99))
   (accesorio (nombre Amplificador) (categoria electronics) (precio 399.99)))

(deffacts MAIN::tarjetas-credito
   (tarjeta-credito (banco bbva) (grupo visa) (exp-date 01-12-23))
   (tarjeta-credito (banco santander) (grupo mastercard) (exp-date 03-07-25)))

(deffacts MAIN::vales
   (vale (codigo ABC123) (valor 500) (fecha-expiracion 01-12-24))
   (vale (codigo XYZ456) (valor 1000) (fecha-expiracion 15-12-24)))

(deffacts MAIN::products
   (product (name USBMem) (category storage) (part-number 1234) (price 199.99))
   (product (name Amplifier) (category electronics) (part-number 2341) (price 399.99))
   (product (name "Rubber duck") (category mechanics) (part-number 3412) (price 99.99)))

(deffacts MAIN::customers
   (customer (customer-id 101) (name joe) (address bla bla bla) (phone 3313073905))
   (customer (customer-id 102) (name mary) (address bla bla bla) (phone 333222345))
   (customer (customer-id 103) (name bob) (address bla bla bla) (phone 331567890)))

(deffacts MAIN::orders
   (order (order-number 300) (customer-id 102))
   (order (order-number 301) (customer-id 103)))

(deffacts MAIN::items-list
   (line-item (order-number 300) (customer-id 102) (part-number 1234))
   (line-item (order-number 301) (customer-id 103) (part-number 2341) (quantity 10)))

(deffacts MAIN::stock
   (stock (part-number 1001) (name "iPhone16") (category "smartphone") (price 27000) (stock 100))
   (stock (part-number 1002) (name "MacBook Air") (category "computadora") (price 47000) (stock 50)))

(defrule MAIN::productos-comprados
   (order (order-number ?order))
   (line-item (order-number ?order) (part-number ?part))
   (smartphone (modelo ?modelo) (precio ?precio))
   =>
   (printout t "El cliente ha comprado un smartphone: " ?modelo " con un precio de " ?precio crlf))

(defrule MAIN::computadoras-compradas
   (order (order-number ?order))
   (line-item (order-number ?order) (part-number ?part))
   (computadora (modelo ?modelo) (precio ?precio))
   =>
   (printout t "El cliente ha comprado una computadora: " ?modelo " con un precio de " ?precio crlf))

(defrule MAIN::accesorios-comprados
   (order (order-number ?order))
   (line-item (order-number ?order) (part-number ?part))
   (accesorio (nombre ?nombre) (precio ?precio))
   =>
   (printout t "El cliente ha comprado un accesorio: " ?nombre " con un precio de " ?precio crlf))

(defrule MAIN::clientes-smartphone
   (customer (customer-id ?id) (name ?name))
   (order (order-number ?order) (customer-id ?id))
   (line-item (order-number ?order) (part-number ?part))
   (smartphone (modelo ?modelo) (precio ?precio))
   =>
   (printout t ?name " compró el smartphone " ?modelo " por " ?precio crlf))

(defrule MAIN::clientes-con-vale
   (customer (customer-id ?cid) (name ?name))
   (order (order-number ?order) (customer-id ?cid))
   (line-item (order-number ?order) (part-number ?part))
   (vale (codigo ?codigo) (valor ?valor))
   =>
   (printout t ?name " tiene un vale con código " ?codigo " por un valor de " ?valor crlf))

(defrule MAIN::descuento-tarjeta
   (customer (customer-id ?cid) (name ?name) (phone ?phone))
   (tarjeta-credito (banco ?banco) (grupo ?grupo))
   =>
   (printout t ?name " con tarjeta de " ?grupo " de " ?banco " tiene un 10% de descuento en su próxima compra" crlf))

(defrule MAIN::iphone16-banamex-24-meses
   (order (order-number ?order) (customer-id ?cid))
   (line-item (order-number ?order) (part-number ?part) (customer-id ?cid))
   (smartphone (modelo iPhone16) (precio ?precio))
   (tarjeta-credito (banco banamex) (grupo oro))
   =>
   (printout t "El cliente con ID " ?cid " ha comprado un iPhone 16 con tarjeta Banamex Oro y tiene 24 meses sin intereses." crlf))

(defrule MAIN::samsung-note21-liverpool-12-meses
   (order (order-number ?order) (customer-id ?cid))
   (line-item (order-number ?order) (part-number ?part) (customer-id ?cid))
   (smartphone (modelo "Samsung Note 21") (precio ?precio))
   (tarjeta-credito (banco liverpool) (grupo visa))
   =>
   (printout t "El cliente con ID " ?cid " ha comprado un Samsung Note 21 con tarjeta Liverpool VISA y tiene 12 meses sin intereses." crlf))

(defrule MAIN::oferta-vales-macbook-iphone
   ?order <- (order (order-number ?order) (customer-id ?cid))
   ?line-item1 <- (line-item (order-number ?order) (part-number ?part1) (customer-id ?cid))
   ?line-item2 <- (line-item (order-number ?order) (part-number ?part2) (customer-id ?cid))
   (computadora (modelo "MacBook Air") (precio ?precio1))
   (smartphone (modelo iPhone16) (precio ?precio2))
   =>
   (bind ?total (+ ?precio1 ?precio2))
   (bind ?vales (mod ?total 1000))
   (bind ?valor-vales (* (div ?total 1000) 100))
   (printout t "¡Felicidades! " ?cid " ha comprado una MacBook Air y un iPhone 16 al contado. " "Recibirá " ?valor-vales " pesos en vales." crlf))

(defrule MAIN::oferta-funda-mica-smartphone
   (order (order-number ?order) (customer-id ?cid))
   (line-item (order-number ?order) (part-number ?part) (customer-id ?cid))
   (smartphone (modelo ?modelo) (precio ?precio))
   (accesorio (nombre ?nombre) (categoria storage) (precio ?precio_accesorio))
   =>
   (bind ?descuento (* ?precio_accesorio 0.15))
   (bind ?precio_final (- ?precio_accesorio ?descuento))
   (printout t "El cliente con ID " ?cid " ha comprado un smartphone y recibe una funda y mica con un 15% de descuento." crlf)
   (printout t "Precio original del accesorio: " ?precio_accesorio ", precio con descuento: " ?precio_final crlf))

(defrule MAIN::clasificar-cliente
   (order (order-number ?order) (customer-id ?cid))
   (line-item (order-number ?order) (part-number ?part) (customer-id ?cid) (quantity ?qty))
   =>
   (if (< ?qty 10)
      then
      (printout t "Cliente ID " ?cid " clasificado como Menudista." crlf)
      else
      (printout t "Cliente ID " ?cid " clasificado como Mayorista." crlf)))

(defrule MAIN::aplicar-descuento-cantidad
   (line-item (order-number ?order) (part-number ?part) (customer-id ?cid) (quantity ?qty))
   (smartphone (marca apple) (modelo iPhone16) (precio ?precio))
   =>
   (if (> ?qty 10)
      then
      (bind ?descuento (* ?precio 0.1))
      (printout t "Descuento de mayorista aplicado: 10%. Precio final: " (- ?precio ?descuento) crlf)
      else
      (printout t "No aplica descuento por cantidad para menudista." crlf)))

(defrule MAIN::actualizar-stock
   (order (order-number ?order) (customer-id ?cid))
   (line-item (order-number ?order) (part-number ?part) (quantity ?qty))
   ?stock <- (stock (part-number ?part) (name ?name) (category ?category) (price ?price) (stock ?current-stock&:(>= ?current-stock ?qty)))
   =>
   (bind ?nuevo-stock (- ?current-stock ?qty))
   (modify ?stock (stock ?nuevo-stock))
   (printout t "Actualizado el stock de " ?name " después de la compra. Nuevo stock: " ?nuevo-stock crlf))

