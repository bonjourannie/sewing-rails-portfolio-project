Rails.application.routes.draw do
  root 'users#welcome'

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get '/projects/most_materials', to: 'projects#most_materials', as: "projects_most_materials"
  get '/projects/:id/materials', to: 'project_materials#index', as: "project_material_index"
  get '/projects/:id/materials/new', to: 'project_materials#new', as: "project_material_new"


  resources :projects
  resources :project_materials
  resources :materials
  resources :categories

  resources :users do 
    collection do 
      get :most_recipes 
    end
  end

  
  get '/auth/google_oauth2/callback' => 'sessions#create_with_google'

end
