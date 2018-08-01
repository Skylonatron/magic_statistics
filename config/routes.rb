Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords' }

  resources :users, only: [:show]

  root to: 'decks#index'
  
  resources :decks do 
    collection do 
      get '/user/:user_id', to: 'decks#user_index', as: :user

    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
