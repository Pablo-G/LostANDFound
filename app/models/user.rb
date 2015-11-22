# Modelo que representa a un usuario
class User < ActiveRecord::Base
  acts_as_authentic             # Para Authlogic
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
end
