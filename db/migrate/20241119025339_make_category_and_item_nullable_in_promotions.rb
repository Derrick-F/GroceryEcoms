class MakeCategoryAndItemNullableInPromotions < ActiveRecord::Migration[7.2]
  def change
    change_column_null :promotions, :item_id, true
    change_column_null :promotions, :category_id, true
  end
end
