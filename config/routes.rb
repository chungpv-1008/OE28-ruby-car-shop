Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home#index"

    get "/about-us", to: "static_pages#about_us"
    get "/contact-us", to: "static_pages#contact_us"
    get "/car-list", to: "posts#index"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout",  to: "sessions#destroy"
    post "favorite_lists/update"

    resources :favorite_lists, only: %i(show update index)
    resources :posts
    resources :users, only: %i(show new create)

    namespace :admins do
      root "posts#index"
      resources :posts
    end
  end
end
