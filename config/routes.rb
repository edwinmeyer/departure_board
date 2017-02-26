Rails.application.routes.draw do
  root 'departure_boards#index'

  resources :departure_boards, only: [:index, :show]
end
