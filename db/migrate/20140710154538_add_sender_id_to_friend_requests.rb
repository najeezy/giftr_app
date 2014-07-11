class AddSenderIdToFriendRequests < ActiveRecord::Migration
  def change
    add_column :friend_requests, :sender_id, :integer
  end
end
