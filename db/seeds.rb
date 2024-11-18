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

# Items
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
