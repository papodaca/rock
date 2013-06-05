Rock::Application.routes.draw do
  root to: "main#index"

  scope "api" do
    resources :users, :only => [:create]
    resources :sessions, :only => [:create]
    resources :libraries, :only => [:index, :show, :update, :destroy] do
      post 'scan'
    end
    resources :songs, :only => [:index, :show] do
      get 'stream'
    end
    resources :albums, :only => [:index, :show]
    resources :genres, :only => [:index] do
      resources :songs, :only => [:index]
    end
    resources :playlists, :only => [:index, :show]
    resources :artists, :only => [:index, :show] do
      resources :songs, :only => [:index]
      resources :albums, :only => [:index]
    end
  end

  match "*path" => "main#index", :via => :get

end
