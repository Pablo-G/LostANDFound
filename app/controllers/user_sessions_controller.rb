# coding: utf-8

# Controlador para las sesiones de usuario
class UserSessionsController < ApplicationController

  # Inicia sesión
  def create
    # Inicia sesión con los parámetros que recibe
    @user_session = UserSession.new(user_session_params)

    if @user_session.save      
      # Por ahora se redirige a la página de inicio del usuario que accede.
      redirect_back
    else
      render 'pages/sign_in', locals: {user_session: @user_session}
    end
  end

  # Cierra sesión
  def destroy
    current_user_session.destroy
    redirect_to (request.referrer.present? ? :back : root_path)
  end

  private

  # Método auxiliar que filtra los atributos permitidos en UserSession
  def user_session_params
    params.require(:user_session).permit(:email, :password,
                                         :remember_me)
  end
  
end

