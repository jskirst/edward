Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :workflows, param: :token do
      resources :steps, param: :token
      resources :answers, param: :name
      resources :prompts
    end

    resources :answers, only: [] do
      resources :options
    end
  end
end
