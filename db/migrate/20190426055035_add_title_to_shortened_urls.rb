class AddTitleToShortenedUrls < ActiveRecord::Migration[5.2]
  def change
    add_column :shortened_urls, :title, :string
  end
end
