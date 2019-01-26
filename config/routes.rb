Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'application#index'

  resources :parking_transactions, except: [:edit, :destroy] do
    collection do
      get :check_out
    end
  end

  resources :garages do

  end
end
