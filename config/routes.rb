Rock::Application.routes.draw do
  root to: "main#index"

  scope "api" do
    resources :users, :only => [:create]
    resources :sessions, :only => [:create] do
      get 'test', :on => :collection
      delete 'logout', :on => :collection
    end
    resources :libraries, :only => [:index, :create, :show, :update, :destroy] do
      post 'scan', :on => :member
    end
    resources :songs, :only => [:index, :show] do
      get 'stream', :on => :member
    end
    resources :albums, :only => [:index, :show]
    resources :genres, :only => [:index] do
      resources :songs, :only => [:index]
    end
    resources :playlists, :only => [:index, :show]
    resources :artists, :only => [:index] do
      resources :songs, :only => [:index]
      resources :albums, :only => [:index]
    end
    resources :doc, :only => [:index] do
      collection do
        get 'sessions'
        get 'users'
        get 'libraries'
        get 'songs'
        get 'albums'
        get 'genres'
        get 'playlists'
        get 'artists'
      end
    end
  end

  match "*path" => "main#index", :via => :get

end
