# coding: utf-8

# Controlador para las sesiones de usuario
class UserSessionsController < ApplicationController

  # Crea una nueva sesión, la vista asociada es la pantalla
  # de inicio de sesión.
  def new
    @user_session = UserSession.new
  end

  # Inicia sesión
  def create
    # Inicia sesión con los parámetros que recibe
    @user_session = UserSession.new(user_session_params)

    if @user_session.save      
      # Por ahora se redirige a la página de inicio del usuario que accede.
      # En teoría habría que regresar a la página anterior
      redirect_to session_index_path
    else
      render :new
    end
  end

  # Cierra sesión
  def destroy
    current_user_session.destroy
    # Se podría cambiar para redirigir a la página anterior
    redirect_to root_path
  end

  private

  # Método auxiliar que filtra los atributos permitidos en UserSession
  def user_session_params
    params.require(:user_session).permit(:email, :password,
                                         :remember_me)
  end
  
end

