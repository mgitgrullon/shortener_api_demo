class CreateShortenedUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :shortened_urls do |t|
      t.text :original_url
      t.string :short_url
      t.string :sanitize_url
      t.integer :counter, default: 1
      t.timestamps
    end
  end
end
