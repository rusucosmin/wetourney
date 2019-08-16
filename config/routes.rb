Rails.application.routes.draw do
  resources :rounds
  resources :matches
  resources :tournaments do
    member do
      get :generate_first_round
      get :generate_next_round
    end
  end

  root to: 'pages#home'
  get :top32, to: 'pages#top32'
end
