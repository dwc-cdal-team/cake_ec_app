Rails.application.routes.draw do

  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: "homes#top"
    get '/about', to: 'homes#about', as: 'about'
    resources :items, only: [:index,:show]
    resource :customers, only: [:edit,:update]
    get '/customers/my_page', to: 'customers#show', as: 'my_page'
    get 'customers/confirm'
    patch 'customers/deactivate'
    resources :carts, except: [:show,:new,:edit]
    delete 'carts/destroy_all'
    resources :orders, except: [:edit,:update,:destroy]
    post 'orders/confirm'
    get 'orders/complete'
    resources :destinations, except: [:show,:new]
  end

  namespace :admin do
    root to: "homes#top"
    resources :items, except: [:destroy]
    resources :genres, except: [:new,:show,:destroy]
    resources :customers, except: [:new,:create,:destroy]
    resources :orders, only: [:show,:update]
    resources :order_items, only: [:update]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

