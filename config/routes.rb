Rails.application.routes.draw do
  get 'account_activations/edit'

  get 'account_actiovations/edit'

  get 'sessions/new'

  root 'static_pages#hello'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users
  resources :account_activations, only: [:edit]

end