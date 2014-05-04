Rosen::Application.routes.draw do
  
  root to: "main#index"
  get '/privacy', to: 'main#privacy'
  get '/about', to: 'main#about'
  get '/stats', to: 'users#all_stats', defaults: {format: :json}
    
  # Authentication
  get 'auth/:provider/callback', to: 'users#create_from_facebook'
  get 'auth/failure', to: redirect('/')
  get 'login', to: 'users#login'
  get 'logout', to: 'users#logout'
  get 'me', to: 'users#me', defaults: {format: :json}
  
  # Pages
  resources :pages, defaults: {format: :json} do
    get 'photo', to: 'pages#photo'
  end
  
  # Game
  resources :users, defaults: {format: :json} do
    get '/stats', to: 'users#stats'
    resources :games do
      post 'submit_answers', to: 'games#submit_answers'
    end
  end
  
  # Routes for templates (not in assets bc I18n works only in views)
  scope 'templates' do
    get '/directives/:name', controller: 'templates', action: 'directive'
    get '/:subdirectory/:name', controller: 'templates', action: 'subdirectory'
    get '/:action', controller: 'templates'
  end
  
  # Whitelisted routes
  get '/play/:id', to: 'main#index'
  get '/play/:id/review', to: 'main#index'
  get '/results', to: 'main#index'
  get '/results/:id', to: 'main#index'
  
end
