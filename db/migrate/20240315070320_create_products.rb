class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.references :sub_category, null: false, foreign_key: true
      t.string :name
      t.string :description
      t.string :size
      t.string :color
      t.integer :price
      t.integer :stock_quantity
      t.string :image_url
      t.string :gender_target

      t.timestamps
    end
  end
end
