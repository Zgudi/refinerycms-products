::Refinery::Application.routes.draw do
  resources :products
  resources :categories, :only => [:index, :show]
  resources :customers, :only => [:index, :show]
  resources :addresses
  resources :profiles
  resources :carts, :only => [:index, :show]
  resources :line_items, :only => [:index, :show]

  match "account_details" => "profiles#account_details", :as => "account_details"
  match "address_details" => "profiles#address_details", :as => "address_details"
  match "order_history" => "profiles#order_history", :as => "order_history"
  match "order_history_details/:order_number" => "profiles#order_history_details", :as => "order_history_details"

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :products do
      collection do
        put  :update_prices
        post :update_positions
      end
    end
  end

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :categories, :except => :show do
      resources :products
      collection do
        post :update_positions
      end
    end
  end

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :customers do
      collection do
        post :update_positions
      end
    end
  end

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :carts, :except => :show do
      collection do
        post :update_positions
      end
    end
  end

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :line_items, :except => :show do
      collection do
        post :update_positions
      end
    end
  end
end
