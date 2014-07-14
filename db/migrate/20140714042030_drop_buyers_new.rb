class DropBuyersNew < ActiveRecord::Migration
  def change
    drop_table :buyers_new
  end
end
