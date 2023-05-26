Rails.application.routes.draw do
  get '/', to: 'pages#index', as: :root

  # Sessions
  get '/sign_in', to: 'sessions#new', as: :sign_in
  delete '/sign_out', to: 'sessions#destroy', as: :sign_out
  resources :sessions, only: [:create]

  # Omniauth
  get 'auth/:provider/callback', to: 'omniauth#create'
  get 'auth/failure', to: 'omniauth#failure'

  # Passwords
  get '/passwords/reset', to: 'passwords#new', as: :reset_password
  resources :passwords, only: [:create] do
    collection do
      patch '/', to: 'passwords#update'
    end
  end

  # Registrations
  get '/sign_up', to: 'registrations#new', as: :sign_up
  resources :registrations, only: [:create, :update] do
    collection do
      patch 'confirm', to: 'registrations#confirm', as: :confirm_registration
      patch '/accept-invitation', to: 'registrations#accept_invitation', as: :accept_invitation
      patch '/cancel-email-change', to: 'registrations#cancel_email_change', as: :cancel_email_change
    end
  end

  resources :organizations, only: [:index, :show, :create, :update, :destroy]
  resources :memberships, only: [:create, :update, :destroy]
end
