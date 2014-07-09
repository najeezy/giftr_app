class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id, :friend_id, presence: true
  validates :user_id, :friend_id, numericality: {greater_than: 0}

  after_create :friend_back

  def friend_back
    friending = Friendship.last

    friender = User.find(friending.user_id)
    friendee = User.find(friending.friend_id)

    if !friendee.friends.include?(friender)
      friendee.friends << friender
    end
  end
end
