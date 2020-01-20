Rails.application.routes.draw do
  root to: 'users#welcome'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to 'sessions#destroy', as: 'logout'

  resources :projects
  resources :project_materials
  resources :materials
  resources :categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
