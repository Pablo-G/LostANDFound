# coding: utf-8

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  # Función auxiliar para agregar mensajes para el usuario
  # Los tipos aceptados son success, info, warning y danger,
  # ya sea como símbolo o como cadena
  def add_message(type, contents)
    return unless type && contents
    flash[:messages] ||= []
    flash[:messages] << { :type => type, :contents => contents }
  end
  
  # Redirije a la página de inicio de sesión, agrega el mensaje
  # adecuado y guarda la página destino en session[:original_uri]
  def redirect_to_login
    add_message :warning, "Necesitas iniciar sesión para hacer eso"
    session[:original_uri] = request.url
    redirect_to sign_in_path
  end
  # Redirije a la página indicada en session[:original_uri]
  # o a la raiz si ninguna
  def redirect_back
    uri = session[:original_uri] || root_path
    session[:original_uri] = nil
    redirect_to uri
  end
      

  # Función auxiliar para recorrer los mensajes para el usuario
  # Después de recorrerlos, los limpia
  def traverse_messages
    flash[:messages].each do |m|
      yield m["type"]||m[:type], m["contents"]||m[:contents]
    end if flash[:messages]
    flash[:messages] = nil
  end
  helper_method :traverse_messages

  # Función auxiliar que regresa la sesión actual
  # Es accesible desde cualquier controlador
  def current_user_session
    # Si está definida la regresa
    return @current_user_session if defined?(@current_user_session)
    # Si no, la busca
    @current_user_session = UserSession.find
  end

  # Función auxiliar que regresa el usuario actual
  # Es accesible desde cualquier controlador
  def current_user
    # Si está definida la regresa
    return @current_user if defined?(@current_user)
    # Si current_user_session da nil, @current_user se vuelve nil
    # Si no, se vuelve el usuario en la sesión actual
    @current_user = current_user_session && current_user_session.user
  end

  # Hace los métodos accesibles desde la vista
  helper_method :current_user_session, :current_user
  
end
