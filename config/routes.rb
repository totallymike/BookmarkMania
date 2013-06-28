BookmarkMania::Application.routes.draw do
  resource :bookmarks, only: [:create]
  root to: 'welcome#index'
end
