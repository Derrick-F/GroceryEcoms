class AddThresholdAndDiscountFieldsToPromotions < ActiveRecord::Migration[7.2]
  def change
    add_column :promotions, :buy_quantity, :integer
    add_column :promotions, :free_quantity, :integer
    add_column :promotions, :free_discount, :decimal
  end
end
