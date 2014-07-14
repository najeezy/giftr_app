class DropBuyers < ActiveRecord::Migration
  def change
    drop_table :buyers
  end
end
