Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  scope "/api", defaults: { format: :json } do
    resources :courses, only: [ :index, :show ]

    scope "/course" do
      get "/submission/:id", to: "submissions#index"
      post "/submission", to: "submissions#create"
    end

    # auth
    post "/login", to: "login#perform"
  end
end
