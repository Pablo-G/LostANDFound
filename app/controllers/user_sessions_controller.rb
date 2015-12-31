# coding: utf-8

# Controlador para las sesiones de usuario
class UserSessionsController < ApplicationController

  # Inicia sesión
  def create
    # Inicia sesión con los parámetros que recibe
    @user_session = UserSession.new(user_session_params)
    user = User.find_by_email(user_session_params[:email])
    if user && user.blocked
      @user_session.errors.add :base, "Usuario bloqueado"
      render 'pages/sign_in', locals: {user_session: @user_session} and return
    end

    if @user_session.save
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

