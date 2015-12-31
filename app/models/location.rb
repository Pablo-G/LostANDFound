# coding: utf-8
class Location < ActiveRecord::Base
  has_many :childs, class_name: "Location", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Location"
  validates :name, presence: true
  has_many :lost_objects

  # Genera una lista con todos los lugares que podrían ser este,
  # por la contención en cualquier sentido
  def related
    return descendants + [self] + ancestors
  end

  # Regresa los lugares que no descienden de ninguno.
  # Si vemos los lugares como una gráfica, son las raíces
  # de cada árbol (si hay varios)
  def self.roots
    where("parent_id IS NULL")
  end

  
  protected

  # Genera una lista con los descendientes de este lugar
  def descendants
    res = []
    prev = [self]
    until prev.empty? do
      nex = Location.where(parent: prev)
      res = res + nex
      prev = nex
    end
    return res
  end

  # Genera una lista con los ancestros de este lugar
  def ancestors
    res = []
    current = parent
    while current
      res << current
      current = current.parent
    end
    return res
  end
end
