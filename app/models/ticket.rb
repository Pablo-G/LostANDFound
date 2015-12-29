# coding: utf-8
class Ticket < ActiveRecord::Base
  belongs_to :lost_object, dependent: :destroy
  belongs_to :user, dependent: :destroy
  has_many :replies

  # Agrega 0 al principio para que las cadenas queden de al menos 6 caracteres
  def IDPrettyFormat
  	return "%06d" % id
  end

  # Dice si u es el último usuario que publico una respuesta
  def lastReply?(u)
  	if replies.last
  		if lastReplyU == u
  			return true
  		end
  	end
  	return false
  end

  private

  # Regresa al último usuario que publico una respuesta 
  def lastReplyU
  	return replies.last.user
  end
end
