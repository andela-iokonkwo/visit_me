class User < ActiveRecord::Base
  has_many :visitors
  def self.first_or_create_from_omniauth(auth)
    counter = User.count
    where(provider: auth.provider, uid: auth.uid).first_or_create do | user |
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.role = counter == 0 ? 'admin' : 'employee'
    end
  end
end