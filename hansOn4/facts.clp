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

