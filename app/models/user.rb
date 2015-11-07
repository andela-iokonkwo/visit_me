class User < ActiveRecord::Base

  def self.first_or_create_from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do | user |
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.role = 'employee'
    end
  end
end