class CreatePromotions < ActiveRecord::Migration[7.2]
  def change
    create_table :promotions do |t|
      t.string :promo_type
      t.decimal :value
      t.datetime :start_time
      t.datetime :end_time
      t.references :category, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
