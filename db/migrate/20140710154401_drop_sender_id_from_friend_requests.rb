class DropSenderIdFromFriendRequests < ActiveRecord::Migration
  def change
    remove_column :friend_requests, :sender_id
  end
end
