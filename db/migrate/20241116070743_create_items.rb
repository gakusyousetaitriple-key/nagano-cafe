class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :genre, null: false, foraign_key: true
      t.string :name, null: false
      t.integer :price, null: false
      t.text :introduction, null: false
      t.boolean :is_active, null: false, default: true
      t.timestamps 
    end

    add_index :items, :is_active
    add_foreign_key :items, :genres
  end
end
