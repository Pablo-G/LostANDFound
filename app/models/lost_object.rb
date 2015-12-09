# coding: utf-8
class LostObject < ActiveRecord::Base
  has_attached_file :image,
                    styles: { thumb: ["268x249#", :jpg],
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
  actable                       # Para la herencia

  validates :user, presence: true

  # Determina si el usuario dado tiene permisos de edición
  # sobre el objeto
  def authorized?(u)
    u && (u == user || u.is_mod?)
  end

  # Los distintos tipos específicos de objeto
  def self.types
    [:phone, :notebook, :glasses, :laptop, :backpack, :other]
  end

  # Para poder manejar los datos de las subclases
  attr_accessor :brand, :model, :company, :case, :cracked_screen # phone
end


class Phone < ActiveRecord::Base
  acts_as :lost_object
end
class Backpack < ActiveRecord::Base
  acts_as :lost_object
end
class Notebook < ActiveRecord::Base
  acts_as :lost_object
end
class Glasses < ActiveRecord::Base
  acts_as :lost_object
end
class Laptop < ActiveRecord::Base
  acts_as :lost_object
  
  # Busquedas simples
  def search(search)
    where("name LIKE ? 
    OR category LIKE ? 
    OR description LIKE ?",
    "%#{search}%", 
    "%#{search}%",
    "%#{search}%")
  end
end
