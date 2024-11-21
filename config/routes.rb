Rails.application.routes.draw do
  namespace :admin do
    get 'orders/index'
    get 'orders/show'
  end
  namespace :public do
    get 'addresses/index'
    get 'addresses/edit'
  end
  namespace :admin do
    get 'homes/top'
  end
  # Public routes
  root 'public/homes#top', as: 'top'
  get '/about', to: 'public/homes#about', as: 'about'
  



  # 顧客用
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  namespace :public do
    resource :customer, only: [:show, :edit, :update,] do
      get 'my_page', to: 'customers#show'
      get 'information/edit', to: 'customers#edit'
      patch 'information', to: 'customers#update'
      get 'unsubscribe', to: 'customers#unsubscribe'
      patch 'withdraw', to: 'customers#withdraw'
    end
    
    resources :items, only: [:index, :show]


    resources :cart_items, only: [:index, :create, :update, :destroy] do
      delete 'destroy_all', on: :collection
    end

    resources :orders, only: [:new, :create, :index, :show] do
      post 'confirm', on: :collection
      get 'thanks', on: :collection # ここで'public/orders/thanks'のルートを定義
    end

    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
  end


  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    root 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:index]
    get '/customer/:id/orders' => 'customers#orders', as: :order_admin_customer
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update] do
      resources :order_details, only: [:update]
    end
  end
end

