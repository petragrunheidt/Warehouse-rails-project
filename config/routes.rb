Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]
  resources :suppliers, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :product_models, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  resources :orders, only: [:index, :show, :new, :create, :edit, :update] do
    resources :order_items, only: [:new, :create]
    get 'search', on: :collection
    patch :set_pending, on: :member
    patch :set_canceled, on: :member
    patch :set_delivered, on: :member
  end
end
