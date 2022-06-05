Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  #rootは'/'を意味する ∴root to: は get '/' => 'home#index'と同じ
  #rootを使用することでURLヘルパー指定が可能になる rails/info/routesにヘルパーurlが追加される
  #root to: 'home#index'
  root to: 'articles#index'

  #get '/' => 'home#index'
  #get '/about' =>'home#about'

  #resources :articles, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  # 上記のonlyは[:index, :show, :new, :create, :edit, :update, :destroy]の部分を指しているのでonly以降は不要
  resources :articles

end
