Rails.application.routes.draw do
  get "home/index"
  get "/institutions/search", to: "institutions#search"
  resources :institutions
  get "students/search", to: "students#search"
  resources :students
  resources :enrollments
  resources :invoices

  # API JSON namespace
  namespace :api do
    namespace :v1 do
      resources :institutions, defaults: { format: :json }
      resources :students, defaults: { format: :json }
      resources :enrollments, defaults: { format: :json }
      resources :invoices, defaults: { format: :json }
    end
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
