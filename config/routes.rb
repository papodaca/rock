Rock::Application.routes.draw do
  root to: "main#index"

  scope "api" do
    resources :users, :only => [:create]
    resources :sessions, :only => [:create]
    resources :libraries, :only => [:index, :create, :show, :update, :destroy] do
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
    resources :doc, :only => [:index]
    scope "doc" do
      match 'sessions' => 'doc#sessions'
      match 'users' => 'doc#users'
      match 'libraries' => 'doc#libraries'
      match 'songs' => 'doc#songs'
      match 'albums' => 'doc#albums'
      match 'genres' => 'doc#genres'
      match 'playlists' => 'doc#playlists'
      match 'artists' => 'doc#artists'
    end
  end

  match "*path" => "main#index", :via => :get

end
