# coding: utf-8
class Ticket < ActiveRecord::Base
  belongs_to :lost_object, dependent: :destroy
  belongs_to :user, dependent: :destroy
  has_many :replies

  # Agrega 0 al principio para que las cadenas queden de al menos 6 caracteres
  def IDPrettyFormat
  	return "%06d" % id
  end
end
