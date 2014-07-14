class CreateBuyersAgain < ActiveRecord::Migration
  def change
    create_table :buyers do |t|
      t.references :purchaser, polymorphic: true
    end
  end
end
