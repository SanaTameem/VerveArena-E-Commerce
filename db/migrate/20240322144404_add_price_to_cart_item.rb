class AddPriceToCartItem < ActiveRecord::Migration[7.1]
  def change
    add_column :cart_items, :price, :integer
  end
end
