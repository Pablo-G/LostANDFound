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
    render layout: "main"
  end

  def sign_in
    redirect_to root_path if current_user
    @user = User.new
    @user_session = UserSession.new
  end
end
