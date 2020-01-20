Rails.application.routes.draw do
  root 'users#welcome'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :projects
  resources :project_materials
  resources :materials
  resources :categories
  
  get "auth/facebook/callback" =>  'sessions#facebook'
  get "/mostprojects" => "welcome#most_projects"
  get "/most_projects" => "projects#most_projectss"
  #come back to this
  
end
