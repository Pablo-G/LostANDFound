# coding: utf-8
class Ticket < ActiveRecord::Base
  belongs_to :lost_object, dependent: :destroy
  belongs_to :user, dependent: :destroy
  has_many :replies

  # Agrega 0 al principio para que las cadenas queden de al menos 6 caracteres
  def IDPrettyFormat
  	r = "000000" + id.to_s
  	return r[r.mb_chars.length-6,r.mb_chars.length]
  end
end
