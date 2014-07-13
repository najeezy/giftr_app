class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string     :title
      t.date       :date
      t.references :user

      t.timestamps
    end
  end
end
