Rails.application.routes.draw do
  resources :cart_items
  resources :promotions
  resources :items
  resources :categories

  # Cart routes
  resources :carts, only: [ :show ] do
    member do
      post "add_item"
    end
  end

  # Dedicated route for removing items from the cart
  delete "carts/:cart_id/remove_item/:id", to: "carts#remove_item", as: "remove_item_cart"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA support
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Root path
  # root "posts#index"
end
