class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price
      t.string :unit_type
      t.string :brand
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
