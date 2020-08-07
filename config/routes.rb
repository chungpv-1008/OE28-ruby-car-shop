Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/about-us", to: "static_pages#about_us"
    get "/contact-us", to: "static_pages#contact_us"
  end
end
