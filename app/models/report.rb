class Report < ActiveRecord::Base
	belongs_to :ticket, dependent: :destroy
	belongs_to :user

	TCA = 1 # Para tickets cerrados accidentalmente
	CA  = 2 # Para usuarios agresivos
	FC  = 3 # Para usuarios con falta de compromiso
	OT  = 4 # Para otro

	def ITPrettyFormat
		case incidence_type
			when TCA
			  return "Ticket cerrado accidentalmente." 
			when CA    #compare to 2
			  return "Usuario agresivo."
			when FC
			  return "Usuario con falta de compromiso."
			when OT
			  return "Otro."
		end
	end
end
