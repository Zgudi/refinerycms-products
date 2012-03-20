::Refinery::Application.routes.draw do
  devise_for :customers

  resources :products, :only => [:index, :show]

  resources :categories, :only => [:index, :show] do
    resources :products, :only => [:index, :show]
  end

  resources :customers, :only => [:show]
  resources :addresses
  resources :profiles
  resources :carts, :only => [:show]
  resources :line_items, :only => [:delete]

  match "account_details" => "profiles#account_details", :as => "account_details"
  match "address_details" => "profiles#address_details", :as => "address_details"

  match "add_to_cart/:product_id" => "carts#add_to_cart", :as => "add_to_cart"
  match "show_cart" => "carts#show_cart", :as => "show_cart"
  match "increment_cart/:product_id" => "carts#increment_cart", :as => "increment_cart"
  match "destroy_line_item/:id" => "line_items#destroy", :as => "destroy_line_item"

  # Famous Categories
  match 'best_selling' => 'products#best_selling', :as => :best_selling
  match 'featured' => 'products#featured', :as => :featured
  match 'new_product' => 'products#new_product', :as => :new_product

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :products do
      collection do
        put  :update_prices
        post :update_positions
      end
    end
    resources :categories, :except => :show do
      resources :products
      collection do
        post :update_positions
      end
    end
    resources :customers do
      collection do
        post :update_positions
      end
    end
    resources :carts, :except => :show do
      collection do
        post :update_positions
      end
    end
    resources :line_items, :except => :show do
      collection do
        post :update_positions
      end
    end
  end
end
