class User < ActiveRecord::Base

  def self.create_with_omniauth(auth)
    create! do |user|
      user.username = auth['info']['name']
      user.email    = auth['info']['email']
    end
  end

  def self.authenticate (email="", password="")

    user = User.find_by_email(email)

    if user && user.match_password(password)
      return user;
    end

    return false

  end

  def match_password(login_password="")
    password == login_password
  end

end
