Fantasma::Application.routes.draw do
  namespace :admin do
    root to: 'dashboard#index'

    get '/new' => 'dashboard#new', as: :new_post
    get '/:id' => 'dashboard#show'
  end
end
