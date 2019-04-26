class ShortenedUrl < ApplicationRecord
  include HTTParty
  UNIQUE_ID_LENGTH = 6
  validates :original_url, presence: true
  validates_format_of :original_url,
    with: /\A(?:(?:http|https):\/\/)?([-a-zA-Z0-9.]{2,256}\.[a-z]{2,4})\b(?:\/[-a-zA-Z0-9@,!:%_\+.~#?&\/\/=]*)?\z/
  before_create :generate_short_url
  after_save :fetch_title_job

  # simple approach: generates a base36 unique hash without encoding the URL
  def generate_short_url
    url = ([*('a'..'z'),*('0'..'9')]).sample(UNIQUE_ID_LENGTH).join
    old_url = ShortenedUrl.where(short_url: url).last
    if old_url.present?
      self.generate_short_url
    else
      self.short_url = url
    end
  end

  def find_duplicate
    ShortenedUrl.find_by_sanitize_url(self.sanitize_url)
  end

  def increment_counter
    self.counter += 1
    self.save
  end
  
  def sanitize
    self.original_url.strip!
    sanitize_url = self.original_url.downcase.gsub(/(https?:\/\/)|(www\.)/, '')
    self.sanitize_url = "http://#{sanitize_url}"
  end

  def fetch_title
    begin
      self.title = Nokogiri::HTML::Document.parse(HTTParty.get(self.sanitize_url).body).title
      self.save
    rescue HTTParty::Error, SocketError  => e
      puts 'HttParty::Error, ' + e.message
    end
  end

  def fetch_title_job
    UrlTitleJob.perform_later(self)
  end
end
