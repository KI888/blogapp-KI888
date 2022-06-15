Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #rootは'/'を意味する ∴root to: は get '/' => 'home#index'と同じ
  #rootを使用することでURLヘルパー指定が可能になる rails/info/routesにヘルパーurlが追加される
  #root to: 'home#index'
  root to: 'articles#index'

  #get '/' => 'home#index'
  #get '/about' =>'home#about'

  #resources :articles, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  # 上記のonlyは[:index, :show, :new, :create, :edit, :update, :destroy]の部分を指しているのでonly以降は不要
  resources :articles do
    resources :comments, only: [:new, :create]

    resource :likes, only: [:create, :destroy]
  end

  # 単数形に注意 単数なのでindexアクションはpathとして作成されない
  # resourceの場合は:show, :edit, :updateのみで作成することが多い
  resource :profile, only: [:show, :edit, :update]

  resources :favorites, only: [:index]

end
