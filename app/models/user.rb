class User < ActiveRecord::Base
  has_many :friendships
  has_many :friends, through: :friendships

  has_secure_password

  validates :username, :first_name, :password, :password_confirmation, :last_name, presence: true
  validates :username, uniqueness: true
  validates :password, length: { minimum: 8 }

  def suggested_friends
    fb_friends_list = FBHelper.get_fb_friends(self)
    fb_friends_list.map do |fb_friend_hash|
      friend_object = User.find_by(facebook_id: fb_friend_hash['id'].to_s)
    end
  end

  def update_fb_attributes
    self.update_profile_image
    self.update_fb_id
  end

  def update_profile_image
    images_hash = FBHelper.get_profile_images(self)
    self.update_attribute(:small_image_url, images_hash[:small])
    self.update_attribute(:large_image_url, images_hash[:large])
  end

  def update_fb_id
    self.update_attribute(:facebook_id, FBHelper.get_fb_id(self))
  end

  # TEST METHODS

  # def get_fb_credentials
  #   test_users = Koala::Facebook::TestUsers.new(app_id: FBHelper.app_id, secret: FBHelper.app_secret)
  #
  #   test_users.list
  # end

end
