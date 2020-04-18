Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
      # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
      
      resources :dashboard

      resources :users do
        collection do
          post 'set_my_role', to: 'users#set_my_role'
          post 'validate_email', to: 'users#validate_email'
        end
      end
      resources :clients
      resources :statuses
      resources :actions
    end
  end
end
