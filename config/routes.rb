Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json }  do
    resources :workflows, param: :token do
      resources :steps, param: :token
      resources :answers, param: :name
      resources :prompts
    end

    resources :answers, only: [] do
      resources :options
    end
  end

  resource :dashboard
  resources :workflows, param: :token do
    resources :steps, param: :token, only: [:edit, :new, :create, :update, :destroy]
    resources :answers, param: :token
  end

  root to: 'workflows#index'
end
