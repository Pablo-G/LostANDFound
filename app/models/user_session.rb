class UserSession < Authlogic::Session::Base
  # Para verificar la cuenta
  validate :check_if_verified

  private

  def check_if_verified
    errors.add(:base, "No has verificado tu cuenta") unless attempted_record &&
                                                            attempted_record.verified
  end
  
end
