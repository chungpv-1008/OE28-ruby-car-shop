Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

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
    resources :posts, except: %i(edit update destroy)
    resources :users, only: %i(show new create)
  end
end
