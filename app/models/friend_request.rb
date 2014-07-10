class FriendRequest < ActiveRecord::Base
  belongs_to :user

  validates :sender_name, :sender_id, :user_id, presence: true
  validates :sender_id, :user_id, numericality: { greater_than: 0 }

end
