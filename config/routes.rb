BookmarkMania::Application.routes.draw do
  resources :bookmarks, only: [:show, :short_url, :create]
  resources :sites
  get '/:short_url',
      to: 'bookmarks#short_url',
      short_url: /\w{6}/,
      as: :short_url
  root to: 'welcome#index'
end
