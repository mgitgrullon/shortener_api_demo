class ShortenedUrlSerializer < ActiveModel::Serializer
  attributes :id, :original_url, :short_url, :sanitize_url, :counter
end
