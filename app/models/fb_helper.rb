class FBHelper
  def self.get_oauth_object(user)
    Koala::Facebook::OAuth.new(app_id, app_secret, "http://localhost:3000/users/#{user.id}/fb_access")
  end

  def self.get_friends(user)
    graph = Koala::Facebook::API.new(user.fb_access_token)
    graph.get_connections('me', 'friends')
  end

  def self.get_profile_images(user)
    graph = Koala::Facebook::API.new(user.fb_access_token)

    image_urls = {}
    fb_images = graph.batch do |batch_api|
      batch_api.get_connections('me', 'picture?redirect=false')
      batch_api.get_connections('me', 'picture?redirect=false&type=large')
    end

    image_urls[:small] = fb_images.first['data']['url']
    image_urls[:large] = fb_images.last['data']['url']


    image_urls
  end

  def self.get_id(access_token)
    graph = Koala::Facebook::API.new(access_token)
    graph.get_object('me')['id'].to_i
  end

  # TEST Methods

  def self.fb_playground(user)
    @graph = Koala::Facebook::API.new(user.fb_access_token, app_secret)
  end

  # def self.get_access_token(code, user)
  #   HTTParty.get("https://graph.facebook.com/oauth/access_token?client_id=305510936292740&redirect_uri=http://localhost:3000/users/#{user.id}/fb_access&client_secret=59d7fcd67796896198c3c150d4b0ac5c&code=#{code}")
  # end

  def self.app_id
    305510936292740
  end

  def self.app_secret
    '59d7fcd67796896198c3c150d4b0ac5c'
  end
end
