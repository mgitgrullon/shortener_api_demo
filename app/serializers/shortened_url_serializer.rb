class ShortenedUrlSerializer < ActiveModel::Serializer
  attributes :id, :title, :sanitize_url, :counter
end
