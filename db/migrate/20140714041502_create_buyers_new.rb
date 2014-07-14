class CreateBuyersNew < ActiveRecord::Migration
  def change
    create_table :buyers_news do |t|
      t.references :purchaser, polymorphic: true
    end
  end
end
