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

