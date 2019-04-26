Rails.application.routes.draw do
  post "/short_it", to: "shortened_urls#create"
  get "/top", to: "shortened_urls#top"
  get "sanitize/:short_url", to: "shortened_urls#show"
  get "/:short_url", to: "shortened_urls#fetch_original_url"
end
