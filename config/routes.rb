BookmarkMania::Application.routes.draw do
  devise_for :users
  resources :bookmarks, only: [:index, :show, :short_url, :create]
  resources :sites, only: [:show, :index]
  resources :tags, only: [:show, :index]
  get '/search', to: 'search#new'
  get '/:short_url',
      to: 'bookmarks#short_url',
      short_url: /\w{6}/,
      as: :short_url
  root to: 'welcome#index'
end
