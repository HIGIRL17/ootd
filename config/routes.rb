Rails.application.routes.draw do
  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end
  root :to =>"public/homes#top"
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    get 'search' => 'posts#search'
    get 'posts/timeline' => 'posts#index', as: :timeline
    patch 'customers/release' => 'customers#release' , as: :release
    patch 'customers/nonrelease' => 'customers#nonrelease' , as: :nonrelease
    resources :customers, only: [:show,:edit,:update]
    patch 'customers/:id/withdraw' => 'customers#withdraw', as: :withdraw
    resources :tags, only: [:show]
    resources :posts, only: [:new , :create, :show, :edit, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
      get 'favorites' => 'favorites#favorites' ,as: 'fovorites'
    end
    resources :customers do
      resource :relationships, only: [:show, :create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
  end

  namespace :admin do
    root to: 'homes#top'
    resources :customers, only: [:index, :show, :edit, :update]
  end

end
