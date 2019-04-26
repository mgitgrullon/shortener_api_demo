class UrlTitleJob < ApplicationJob
  queue_as :default

  def perform(url)
    url.fetch_title
  end
end