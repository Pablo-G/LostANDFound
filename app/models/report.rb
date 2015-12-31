class Report < ActiveRecord::Base
	belongs_to :ticket, dependent: :destroy
	belongs_to :user

	TCA = 0 # Para tickets cerrados accidentalmente
	CA  = 1 # Para usuarios agresivos
	FC  = 3 # Para usuarios con falta de compromiso
	OT  = 4 # Para otro
end
