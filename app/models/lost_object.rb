# coding: utf-8
class LostObject < ActiveRecord::Base
  has_attached_file :image,
                    styles: { thumb: ["100x100#", :jpg],
                              original: ["500x500>", :jpg] },
                    convert_options: { thumb: "-strip",
                                       original: "-strip" },
                    url: "/images/:style/:hash.:extension",
                    default_url: "/images/:style/missing.jpg",
                    hash_secret: "5bb726e0749f58e322dd5d3d6579e3e5a75"
  validates_attachment :image,
                       content_type: { content_type: ["image/jpeg",
                                                      "image/gif",
                                                      "image/png"] },
                       size: { in: 0..500.kilobytes }
  belongs_to :location
  belongs_to :user

  validates :user, presence: true

  # Determina si el usuario dado tiene permisos de edición
  # sobre el objeto
  def authorized?(u)
    u && (u == user || u.is_mod?)
  end
  
  # Busquedas simples
  def self.search(search)
    where("name LIKE ? 
    OR description LIKE ?",
    "%#{search}%", 
    "%#{search}%")
  end
end
