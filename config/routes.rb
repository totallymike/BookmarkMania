BookmarkMania::Application.routes.draw do
  resources :bookmarks
  root to: 'welcome#index'
end
