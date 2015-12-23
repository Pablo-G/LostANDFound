# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



# Inicialización de la tabla locations
fac = "Facultad de Ciencias"

# Los lugares se deben agregar de la forma:
# [ <nombre del lugar>, <nombre del padre> ]
# Se pueden usar literales o variables, pero con variables se
# escribe menos
lugares = []

# Agrega lugares con números consecutivos en su nombre y un padre
# común. Usa todos los números en [first,last] para sustituir
# en la cadena format
# format debe ser una cadena de formato con una única
# posición dónde sustitiur por un número
def add_consecutive(array, first, last, format, parent)
  (first..last).each do |n|
    array << [ (format % n), parent ]
  end
end

# Edificio P
edifP = "Edificio P"
edifP_1 = "Primer Piso | Edificio P"
edifP_2 = "Segundo Piso | Edificio P"
lugares = lugares + [
  [ edifP, fac ],
  [ "Sótano | Edificio P", edifP ],
  [ "Planta baja | Edificio P", edifP ],
  [ edifP_1, edifP ], [ edifP_2, edifP ]
]
lugares << [ "Aula Magna P", edifP_1 ]
add_consecutive(lugares, 101, 118, "P%d", edifP_1)
add_consecutive(lugares, 201, 213, "P%d", edifP_2)

# Edificio O
edifO = "Edificio O"
edifO_1 = "Primer Piso | Edificio O"
edifO_2 = "Segundo Piso | Edificio O"
lugares = lugares + [
  [ edifO, fac ],
  [ "Planta baja | Edificio O", edifO ],
  [ edifO_1, edifO ], [ edifO_2, edifO ]
]
add_consecutive(lugares, 121, 134, "O%d", edifO_1)
add_consecutive(lugares, 214, 223, "O%d", edifO_2)

# Yelizcalli
yeliz = "Yelizcalli"
yeliz_PB = "Planta baja | #{yeliz}"
yeliz_1 = "Primer Piso | #{yeliz}"
yeliz_2 = "Segundo Piso | #{yeliz}"
yeliz_3 = "Tercer Piso | #{yeliz}"
lugares = lugares + [
  [ yeliz, fac ],
  [ yeliz_PB , yeliz ], [ yeliz_1 , yeliz ],
  [ yeliz_2 , yeliz ], [ yeliz_3 , yeliz ]
]
lugares << [ "Auditorio (#{yeliz})", yeliz_PB ]
add_consecutive(lugares, 1, 4, "%03d (#{yeliz})", yeliz_PB)
add_consecutive(lugares, 101, 106, "%03d (#{yeliz})", yeliz_1)
add_consecutive(lugares, 201, 206, "%03d (#{yeliz})", yeliz_2)
add_consecutive(lugares, 301, 306, "%03d (#{yeliz})", yeliz_3)

# Amoxcalli
amox = "Amoxcalli"
lugares = lugares + [
  [ amox, fac ]
]

# Tlahuizcalpan
tlahuiz = "Tlahuizcalpan"
tlahuiz_S = "Sótano | #{tlahuiz}"
tlahuiz_PB = "Planta baja | #{tlahuiz}"
tlahuiz_1 = "Primer Piso | #{tlahuiz}"
tlahuiz_2 = "Segundo Piso | #{tlahuiz}"
lugares = lugares + [
  [ tlahuiz, fac ],
  [ tlahuiz_S , tlahuiz ], [ tlahuiz_PB , tlahuiz ],
  [ tlahuiz_1 , tlahuiz ], [ tlahuiz_2 , tlahuiz ]
]

# Esta es la parte que agrega los lugares a la base de datos
# Lo anterior sólo indica cuáles son
Location.create( name: fac )
lugares.each do |lugar, padre|
  Location.create( name: lugar, parent: Location.find_by(name: padre) )
end
