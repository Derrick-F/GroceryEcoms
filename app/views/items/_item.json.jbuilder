json.extract! item, :id, :name, :price, :unit_type, :brand, :category_id, :created_at, :updated_at
json.url item_url(item, format: :json)
