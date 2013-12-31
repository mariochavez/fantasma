Fantasma::Application.routes.draw do
  namespace :admin do
    root to: 'dashboard#index'

    get   '/new' => 'dashboard#new', as: :new_post
    get   '/:id' => 'dashboard#show'

    get   '/:id/edit' => 'dashboard#edit', as: :edit_post

    get   '/' => 'dashboard#index', as: :posts
    post  '/' => 'dashboard#create'

    put   '/:id' => 'dashboard#update', as: :post
    patch '/:id' => 'dashboard#update'
  end
end
