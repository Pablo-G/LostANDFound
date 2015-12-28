# coding: utf-8
class LostObject < ActiveRecord::Base
  belongs_to :location
  belongs_to :user
  has_many :images
  has_many :tickets
  accepts_nested_attributes_for :images, allow_destroy: true,
                                reject_if: :all_blank
  actable                       # Para la herencia

  validates :user, presence: true

  # Determina si el usuario dado tiene permisos de edición
  # sobre el objeto
  def authorized?(u)
    u && (u == user || u.is_mod?)
  end
  
  # Busquedas simples
  def self.search(search)
    where("lower(name) LIKE lower(?) 
    OR lower(description) LIKE lower(?)",
    "%#{search}%", 
    "%#{search}%")
  end
  
  def self.types
    [:phone, :laptop, :backpack, :notebook, :glasses, :other]
  end
end
