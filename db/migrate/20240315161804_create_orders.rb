class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.date :order_date
      t.string :status
      t.integer :total_amount

      t.timestamps
    end
  end
end
