class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :address null:false
      t.string :post_code null:false
      t.string :name null:false
      t.interger :total_amount null:false
      t.interger :postage null:false
      t.integer :payment_method null:false
      t.integer :is_order null:false 
      t.timestamps
    end
  end
end
