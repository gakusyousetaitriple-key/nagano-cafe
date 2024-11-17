class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.references :customer, null: false, foraign_key: true
      t.references :item, null: false, foraign_key: true
      t.integer :amount, null: false
      t.timestamps
    end
  end
end
