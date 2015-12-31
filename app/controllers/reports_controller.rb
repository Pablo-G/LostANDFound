# coding: utf-8
# Controlador para Reports
class ReportsController < ApplicationController
  # Crea un reporte
  def create_report
    @newReport = Report.new

    @ticket = Ticket.find(params[:ticket_id])
    @user = User.find(params[:user_id])

    @newReport.ticket = @ticket
    @newReport.user = @user
    @newReport.status = false  # No se ha resuelto
    @newReport.type = params[:case]
    @newReport.message = params[:message]
    if @newReport.save
      add_message :info, "Listo! Un moderador revisará este Ticket lo mas pronto posible."
      redirect_to ticket_path(@newReport.ticket.id)
    else                     
      render :new
    end
  end
end