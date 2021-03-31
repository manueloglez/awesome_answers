Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get('/', { to: 'welcome#index', as: 'root' })
  get('/contact/new', { to: 'contact#new' })
  post('/contact', {to: 'contact#create'})

  resources :questions do
    resources :answers, only:[:create, :destroy], shallow: true
  end

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
end
