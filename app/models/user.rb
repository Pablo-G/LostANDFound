# coding: utf-8

# Modelo que representa a un usuario
class User < ActiveRecord::Base
  acts_as_authentic             # Para Authlogic
  validates :name, presence: true
  validates :email, presence: true
  has_many :lost_objects
  has_many :tickets
  has_many :replies

  # Constantes para los distintos roles.
  # Los valores están ordenados según privilegios
  USER  = 0
  MOD   = 1
  ADMIN = 2

  def is_mod?
    role >= MOD                 # Un administrador también es moderador
  end
  
  def is_admin?
    role == ADMIN
  end
  
  def has_notif?
    lost_objects.each do |lo|
      lo.tickets.each do |lti|
        if lti.new_entry&!lti.lastReply?(self)
          return true
        end
      end  
    end
    
    tickets.each do |ti|
      if ti.new_entry&!ti.lastReply?(self)
        return true
      end
    end

    return false
  end

  def deliver_verification_instructions!
    reset_perishable_token!
    UserMailer.verification_instructions(self).deliver_now
  end

  def verify!
    self.verified = true;
    self.save
    UserSession.create(self)
  end


  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.password_reset(self).deliver_now
  end

end
