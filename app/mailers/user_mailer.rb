# coding: utf-8
class UserMailer < ApplicationMailer

  # La acción para los correos de verificación
  def verification_instructions(user)
    @user = user
    @verification_url = verify_url(@user.perishable_token)
    email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail(to: email_with_name, subject: "Bienvenido a LostANDFound" )
  end
  
end
