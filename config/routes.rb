Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json }  do
    resources :workflows, param: :token do
      resources :steps, param: :token
      resources :answers, param: :token
      resources :options, param: :token
      resources :prompts
    end
  end

  resource :dashboard
  resources :workflows, param: :token do
    resources :steps, param: :token, only: [:edit, :new, :create, :update, :destroy]
    resources :answers, param: :token
    resources :options, param: :token
  end

  resources :answers, only: [], param: :token do
    resources :answers_options, only: [:new, :create, :destroy]
  end

  root to: 'workflows#index'
end
