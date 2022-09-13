Rails.application.routes.draw do
  root to: 'home#index'
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]# do
  #   patch :publish, on: :member
  #   patch :unpublish, on: :member
  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end
