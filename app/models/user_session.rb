class UserSession < Authlogic::Session::Base

  def self.human_name
    "User Session"
  end

end