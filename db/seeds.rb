# This file should ensures the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# Categories
produce = Category.create!(name: "Produce")
dairy = Category.create!(name: "Dairy")
baking = Category.create!(name: "Baking")
seafood = Category.create!(name: "Seafood")
meat = Category.create!(name: "Meat")
dry_grocery = Category.create!(name: "Dry Grocery")

Item.create!([
  { name: "Apple", price: 1.2, unit_type: "weight", brand: "OrganicFarm", category: produce },
  { name: "Arugula", price: 0.8, unit_type: "weight", brand: "Olivia's Organics", category: produce },
  { name: "Milk", price: 2.5, unit_type: "quantity", brand: "Cumberland Farms", category: dairy },
  { name: "Cheese", price: 0.3, unit_type: "quantity", brand: "Cabot Creamery", category: dairy },
  { name: "Bread Flour", price: 1.0, unit_type: "quantity", brand: "King Arthur Baking", category: baking },
  { name: "Salmon Fillet", price: 7.38, unit_type: "weight", brand: "Almeida Fisheries", category: seafood },
  { name: "Chicken Thighs", price: 4.99, unit_type: "weight", brand: "Bell & Evans", category: meat },
  { name: "Penne Pasta", price: 2.30, unit_type: "quantity", brand: "Tarquini Macaroni", category: dry_grocery }
])

Promotion.create!([
  { promo_type: "flat_fee", value: 10.0, start_time: 1.day.ago, end_time: 1.week.from_now, category: Category.find_by(name: "Produce"), item: nil },
  { promo_type: "percentage", value: 20.0, start_time: Time.now, end_time: 3.days.from_now, category: nil, item: Item.find_by(name: "Milk") },
  { promo_type: "buy_x_get_y", value: 1, start_time: Time.now, end_time: 1.month.from_now, category: nil, item: Item.find_by(name: "Penne Pasta") },
  { promo_type: "weight_threshold", value: 0.5, start_time: 1.hour.ago, end_time: 2.weeks.from_now, category: nil, item: Item.find_by(name: "Chicken Thighs") }
])
