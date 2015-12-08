class UserMailer < ApplicationMailer
	default from:'dailexgo@gmail.com'

	# Manda un correo de confirmación al usuario, creando un número de valiación
	# aleatorio e incluyéndolo en el correo.
	def validation_email(user)
		@user = user
		@url = "#{default_url_options[:host]}/validate/#{@user.id}"
		mail(to: @user.email, subject: 'Bienvenido a LostAndFound')
	end
end
