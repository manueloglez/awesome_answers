Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get('/', { to: 'welcome#index', as: 'root' })
  get('/contact/new', { to: 'contact#new' })
  post('/contact', {to: 'contact#create'})

  post('/questions', {to: 'questions#create'})
  get('/questions/new', {to: 'questions#new'})
  get('/questions/:id', {to: 'questions#show', as: 'question'})
  get('/questions', {to: 'questions#index'})
  get('/questions/:id/edit', {to: 'questions#edit', as: 'edit_question'})
  patch('/questions/:id/', {to: 'questions#update', as: 'update_question'})
  delete('/questions/:id', {to: 'questions#destroy', as: 'delete_question'})
end
