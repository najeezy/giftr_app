class CreateBuyers < ActiveRecord::Migration
  def change
    create_table :buyers do |t|
      t.references :purchaser
    end
  end
end
