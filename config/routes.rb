Rails.application.routes.draw do
  root to: 'shortened_urls#index'
  get "/:short_url", to: "shortened_urls#show"
  post "/shortened_urls/create"
  get "/shortened_urls/fetch_original_url"
end
