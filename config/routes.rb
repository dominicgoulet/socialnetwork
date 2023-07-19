Rails.application.routes.draw do
  get '/', to: 'pages#index', as: :root

  # Sessions
  get '/sign_in', to: 'sessions#new', as: :sign_in
  delete '/sign_out', to: 'sessions#destroy', as: :sign_out
  resources :sessions, only: [:create]

  # Omniauth
  get 'auth/:provider/callback', to: 'omniauth#create', as: :omniauth_callback
  get 'auth/failure', to: 'omniauth#failure', as: :omniauth_failure

  # Passwords
  get '/passwords/reset', to: 'passwords#new', as: :reset_password
  get '/edit', to: 'passwords#edit', as: :edit_password
  patch '/', to: 'passwords#update', as: :password
  resources :passwords, only: [:create]

  # Registrations
  get '/sign_up', to: 'registrations#new', as: :sign_up
  get '/profile', to: 'registrations#show', as: :profile
  patch '/profile', to: 'registrations#update'
  get '/profile/edit', to: 'registrations#edit', as: :edit_profile
  resources :registrations, only: [:new, :create] do
    collection do
      patch '/confirm', to: 'registrations#confirm', as: :confirm_registration
      patch '/accept-invitation', to: 'registrations#accept_invitation', as: :accept_invitation
      patch '/cancel-email-change', to: 'registrations#cancel_email_change', as: :cancel_email_change
    end
  end

  # Setup
  scope '/setup' do
    get 'welcome', to: 'setup#welcome', as: :welcome_setup
    get 'person', to: 'setup#person', as: :person_setup
    get 'brand', to: 'setup#brand', as: :brand_setup
    get 'complete', to: 'setup#complete', as: :complete_setup
    patch 'complete', to: 'setup#complete'
  end

  resources :activities
  resources :audiences
  resources :brands
  resources :circles
  resources :comments
  resources :groups
  resources :memberships
  resources :notes
  resources :notifications
  resources :people
  resources :ties
end
