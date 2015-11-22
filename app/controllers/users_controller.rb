# coding: utf-8

# Controlador para los usuarios
class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    # Crea un usuario nuevo con los parámetros que reciba
    @user = User.new(users_params)

    if @user.save            # Si se puede guardar en la base de datos
      # Se puede generar un mensaje de éxito, como
      # flash[:success] = "Registro exitoso"
      
      # Regresa a la raiz
      # Hay que cambiarlo para que redirija a la página de donde vino.
      redirect_to root_path
    else                     # Si no se guardó
      render :new            # Vuelve a mostrar new
    end
  end

  private

  # Método auxiliar que filtra los atributos permitidos en un User
  def users_params
    params.require(:user).permit(:name, :email, :gender, :age,
                                 :password, :password_confirmation)
  end
end
