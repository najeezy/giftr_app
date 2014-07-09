class FBHelper
  def self.get_oauth_object(user)
    Koala::Facebook::OAuth.new(app_id, app_secret, "http://localhost:3000/users/#{user.id}/fb_access")
  end

  def self.fb_playground(user)
    @graph = Koala::Facebook::API.new(user.fb_access_token, app_secret)
  end

  # def self.get_access_token(code, user)
  #   HTTParty.get("https://graph.facebook.com/oauth/access_token?client_id=305510936292740&redirect_uri=http://localhost:3000/users/#{user.id}/fb_access&client_secret=59d7fcd67796896198c3c150d4b0ac5c&code=#{code}")
  # end

  private
  def self.app_id
    305510936292740
  end

  def self.app_secret
    '59d7fcd67796896198c3c150d4b0ac5c'
  end
end
