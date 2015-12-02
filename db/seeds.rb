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
edifP = "Edificio P"
edifP2 = "Segundo piso del edificio P"

# Los lugares se deben agregar de la forma:
# [ <nombre del lugar>, <nombre del padre> ]
# Se pueden usar literales o variables, pero con variables se
# escribe menos
# Ejemplo:
lugares = [
  [ edifP, fac ],
  [ edifP2, edifP ]
]

# También se puede usar append y ciclos
(201..213).each do |n|
  lugares.append [ "P#{n}", edifP2 ]
end

# Esta es la parte que agrega los lugares a la base de datos
# Lo anterior sólo indica cuáles son
Location.create( name: fac )
lugares.each do |lugar, padre|
  Location.create( name: lugar, parent: Location.find_by(name: padre) )
end
