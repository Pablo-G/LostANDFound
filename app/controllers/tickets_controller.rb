# coding: utf-8
# Controlador para Tickets
class TicketsController < ApplicationController
  # Sólo funciona si el usuario ya inició sesión
  def index
    if current_user
      @user = current_user
    else
      redirect_to_login
    end
  end

  # Método show. Solo muestra el ticket si el usuario actual es el dueño del objeto o el dueño del ticket.
  def show
    if current_user
      @ticket = Ticket.find(params[:id])
    	@obOwner = @ticket.lost_object.user
    	@tiOwner = @ticket.user
    	if current_user == @obOwner || current_user == @tiOwner
          @user = current_user
          @reply = Reply.new
    	else
    	  redirect_to root_path
    	end
    else
      redirect_to_login
    end  	
  end

  # Método create. Crea un nuevo ticket. Si el usuario ya había creado uno para el objeto solo lo redirige a este.
  def create
    if current_user
      @current_obj = LostObject.find(params[:lost_object_id])

      current_user.tickets.each do |t|
        if t.lost_object == @current_obj
          redirect_to ticket_path(t) and return
        end
      end

      @newTicket = Ticket.new
      @newTicket.lost_object = @current_obj
      @newTicket.user = current_user
      @newTicket.status = true
      @newTicket.opened_at = DateTime.now
      @newTicket.new_entry = false
      if @newTicket.save
        redirect_to ticket_path(@newTicket)
      else                     
        render :new
      end
    else
      redirect_to_login
    end
  end

  # Crea una nueva respuesta para el ticket
  def create_reply
    @newReply = Reply.new
    @ticket = Ticket.find(params[:ticket_id])
    @newReply.ticket = @ticket
    @newReply.message = params[:reply][:message]
    @newReply.user = current_user
    if @newReply.save
      @ticket.update(:new_entry => true)
      redirect_to ticket_path(@newReply.ticket.id)
    else                     
      render :new
    end
  end

  # Cierra los Tickets
  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update(:status => false)
      redirect_to ticket_path(@ticket)
    else                     
      render :new
    end    
  end

end