class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string     :name
      t.string     :category
      t.integer    :price
      t.text       :small_image_url
      t.text       :large_image_url
      t.text       :amazon_url
      t.text       :specifics
      t.boolean    :status
      t.references :user
      t.references :event
      t.references :buyer

      t.timestamps
    end
  end
end
