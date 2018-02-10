Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    unauthenticated do
      root 'devise/sessions#new'
    end
    authenticated do
      root 'short_urls#index'
    end
  end

  get "/:short_urls", to: "short_urls#show"
  get "shortened/:short_url", to: "short_urls#shortened", as: :shortened
  post "/short_urls/create"
  get "/short_urls/fetch_original_url"
  resources :short_urls 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
