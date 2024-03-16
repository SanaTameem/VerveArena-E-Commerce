class AddRatingToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :rating, :integer
  end
end
