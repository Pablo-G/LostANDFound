# coding: utf-8

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

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
