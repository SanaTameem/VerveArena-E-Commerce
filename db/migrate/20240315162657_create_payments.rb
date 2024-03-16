class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.integer :paid_amount
      t.date :payment_date
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
