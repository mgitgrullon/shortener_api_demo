require 'rails_helper'

RSpec.describe ShortenedUrl, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it { is_expected.to allow_value("www.google.com").for(:original_url) }
  it { is_expected.to allow_value("google.com").for(:original_url) }
  it { is_expected.to allow_value("https://google.com").for(:original_url) }
  it { is_expected.to_not allow_value("google").for(:original_url) }
  it { is_expected.to_not allow_value("www.google").for(:original_url) }

  # Validation tests
  it { should validate_presence_of(:original_url) }
end
