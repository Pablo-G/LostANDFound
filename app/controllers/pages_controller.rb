# coding: utf-8

# Controlador para páginas estáticas.
# 
# Son páginas estáticas en el sentido que no dependen de información
# en la base de datos, pero pueden tener comportamiento
# 
# Para definir una nueva página con ruta <r>, se debe definir
# un método <r> en este controlador y una vista <r>.html.erb
# dentro de app/views/pages y agregar la ruta en config/routes.rb
# con `get '<r>', to: 'pages#<r>'`
class PagesController < ApplicationController
  def index
  end
  
  def session_index
  end
end
