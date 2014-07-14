class DropStatusFromGifts < ActiveRecord::Migration
  def change
    remove_column :gifts, :status
  end
end
