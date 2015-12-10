# coding: utf-8

# Controlador para las sesiones de usuario
class UserSessionsController < ApplicationController

  # Crea una nueva sesión, la vista asociada es la pantalla
  # de inicio de sesión.
  def new
    if current_user_session
      redirect_to root_path
    else
      @user_session = UserSession.new
    end
  end

  # Inicia sesión
  def create
    # Inicia sesión con los parámetros que recibe
    @user_session = UserSession.new(user_session_params)

    if @user_session.save      
      # Por ahora se redirige a la página de inicio del usuario que accede.
      # En teoría habría que regresar a la página anterior
      redirect_to lost_objects_path
    else
      render 'pages/sign_in', locals: {user_session: @user_session}
    end
  end

  # Cierra sesión
  def destroy
    current_user_session.destroy
    # Se podría cambiar para redirigir a la página anterior
    redirect_to lost_objects_path
  end

  private

  # Método auxiliar que filtra los atributos permitidos en UserSession
  def user_session_params
    params.require(:user_session).permit(:email, :password,
                                         :remember_me)
  end
  
end

