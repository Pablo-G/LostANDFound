# coding: utf-8

# Controlador para los usuarios
class UsersController < ApplicationController

  # Sólo funciona si el usuario ya inició sesión
  def show
    if !current_user
      redirect_to root_path and return
    end

    @user = current_user
  end

  def new
    if current_user
      redirect_to root_path
    else
      @user = User.new
    end
  end

  # Sólo funciona si el usuario ya inició sesión
  def edit
    if !current_user
      redirect_to root_path and return
    end

    @user = current_user
  end

  def create
    # Crea un usuario nuevo con los parámetros que reciba
    @user = User.new(users_params)

    if @user.save            # Si se puede guardar en la base de datos
      # Se puede generar un mensaje de éxito, como
      # flash[:success] = "Registro exitoso"
      
      # Regresa a la raiz
      # Hay que cambiarlo para que redirija a la página de donde vino.
      UserMailer.validation_email(@user).deliver_now
      redirect_to root_path
    else                        # Si no se guardó
      render 'pages/sign_in', locals: {user: @user}
    end
  end

  def update
    @user = current_user
    # Permito los mismos atributos que para la creación,
    # salvo email y contraseña
    p = users_params.permit!.except(:email, :password,
                                    :password_confirmation)
    if @user.update(p)
      puts p
      redirect_to user_path
    else
      render :edit
    end
  end

  # Actualiza sólo la contraseña.
  def update_password
    @user = current_user

    if @user.valid_password? params[:user][:current_password]
      # Sólo permito la contraseña como parámetro
      p = params.require(:user).permit(:password,
                                       :password_confirmation)
      if @user.update(p)
        redirect_to user_path and return
      end
    end
    render :edit
  end

  # Método de validación de usuario
  def validate
    @user = User.find(params[:id])
    @user.update_attribute(:validated, true)
    redirect_to root_path
  end

  private

  # Método auxiliar que filtra los atributos permitidos en un User
  def users_params
    params.require(:user).permit(:name, :email, :gender, :age,
                                 :password, :password_confirmation)
  end

end
