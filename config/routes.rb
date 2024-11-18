Rails.application.routes.draw do

  # 顧客用ルーティング
  scope module: :public do
    resources :items, only: [:index, :show] # 顧客用商品一覧・商品詳細
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete :destroy_all # カートを空にするアクション
      end
    end
  end

  # 管理者用ルーティング
  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update] # 管理者用商品管理
  end

  # その他の設定があればここに追加

end
