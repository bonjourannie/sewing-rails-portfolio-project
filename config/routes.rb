Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  root 'users#welcome'

  get '/projects/most_materials', to: 'projects#most_materials', as: "projects_most_materials"
  get '/projects/:id/materials', to: 'project_materials#index', as: "project_material_index"
  get '/projects/:id/materials/new', to: 'project_materials#new', as: "project_material_new"

  get '/users/:user_id/projects', to: 'users#projects'
  
  get '/materials/sort_abc', to: 'materials#sort_ABC'
  get '/materials/sort_by_popularity', to: 'materials#sort_bypopularity'

  get '/auth/github/callback' => 'sessions#create_with_github'

  resources :projects
  resources :project_materials
  resources :sessions 
  
  resources :materials, only: [:index, :show]
  
  resources :categories do 
    collection do 
      get :sort_by_popularity 
      get :sort_ABC
    end 
  end


  resources :users do 
    collection do 
      get :most_projects 
    end
  end

  
  
end
