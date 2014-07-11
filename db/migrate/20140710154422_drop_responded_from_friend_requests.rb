class DropRespondedFromFriendRequests < ActiveRecord::Migration
  def change
    remove_column :friend_requests, :responded
  end
end
