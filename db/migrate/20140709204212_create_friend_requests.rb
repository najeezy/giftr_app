class CreateFriendRequests < ActiveRecord::Migration
  def change
    create_table :friend_requests do |t|
      t.boolean :responded
      t.string :sender_name
      t.string :sender_id
      t.references :user

      t.timestamps
    end
  end
end
