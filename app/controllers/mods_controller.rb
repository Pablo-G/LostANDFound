# coding: utf-8
# Controlador para funciones específicas de los moderadores
class ModsController < ApplicationController

  # Una página especial para moderadores
  # Redirige a login si no hay sesión o a inicio si no hay permisos
  def index
    redirect_to_login unless current_user
    redirect_to root_path unless current_user.is_mod?
    @user = User.new
    @ticket = Ticket.new
  end

  # Reabre un ticket dado su ID
  # El ticket debe estar cerrado
  def reopen_ticket
    if !current_user || !current_user.is_mod?
      redirect_to root_path and return
    end

    p = params.require(:ticket).permit(:id)
    if !p[:id] || !Ticket.exists?(id: p[:id])
      @ticket = Ticket.new(p)
      if !p[:id]
        @ticket.errors.add(:base, "Necesitas dar un ID")
      else
        @ticket.errors.add(:base, "El ticket no existe.")
      end
      render :index and return
    end

    @ticket = Ticket.find(p[:id])
    if @ticket.status
      @ticket.errors.add(:base, "El ticket ya está abierto")
      render :index and return
    end

    @ticket.status = true
    @ticket.save
    add_message :success, "Ticket #{@ticket.IDPrettyFormat} reabierto."
    redirect_to mod_page_path
  end

  # Bloquea a un usuario
  # Esto es: elimina todos sus objetos y su información (salvo correo)
  # y evita que inicie sesión
  def delete_user
    # Checo que haya una sesión
    if !current_user || !current_user.is_mod?
      redirect_to root_path and return
    end

    p = params.require(:user).permit(:email)
    if !p[:email] || !User.exists?(email: p[:email])
      @user = User.new(p)
      if !p[:email]
        @user.errors.add(:base, "Necesitas dar una dirección de correo")
      else
        @user.errors.add(:base, "El usuario no existe.")
      end
      render :index and return
    end

    @user = User.find_by_email(p[:email])

    # Para eliminar debe tener un rol más alto
    if @user.role >= current_user.role
      @user.errors.add(:base, "No tienes suficientes permisos para eso")
      render :index and return
    end

    @user.replies.delete_all
    @user.tickets.delete_all
    @user.lost_objects.delete_all
    
    # @user.blocked = true
    @user.name = "X"
    @user.gender = @user.age = nil

    @user.save

    add_message :success, "Usuario #{@user.email} bloqueado."
    redirect_to mod_page_path
  end
  
end
