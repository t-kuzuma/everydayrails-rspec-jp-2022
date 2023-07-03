Rails.application.routes.draw do

  devise_for :users

  authenticated :user do
    root 'projects#index', as: :authenticated_root
  end

  resources :projects do
    resources :notes
    resources :tasks do
      member do
        patch :toggle
      end
    end
  end

  namespace :api do
    resources :projects do#, only: [:index, :show, :create]
      resources :tasks, only: [:index]
    end
  end

  root "home#index"
end
