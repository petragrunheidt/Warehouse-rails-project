Rails.application.routes.draw do
  root to: 'home#index'
  # resources :books, only: [:show, :new, :create, :edit, :update, :destroy] do
  #   patch :publish, on: :member
  #   patch :unpublish, on: :member
  # end
  # resources :genres, only: [:show, :new, :create, :destroy]
end
