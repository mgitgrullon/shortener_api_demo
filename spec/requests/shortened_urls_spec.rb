require 'rails_helper'

RSpec.describe 'ShortenedUrl API', type: :request do
  # initialize test data 
  let!(:shortened_urls) { create_list(:shortened_url, 100) }

  # Test suite for GET /top
  describe 'GET /top' do
    # make HTTP get request before each test
    before { get '/top' }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns top 100 urls' do
      expect(json).not_to be_empty
      expect(json.size).to eq(100)
    end
  end

  # Test suite for POST /short_it
  describe 'POST /short_it' do
    # valid payload
    let(:valid_attributes) { { original_url: 'www.google.com' } }

    context 'when the request is valid' do
      before { post '/short_it', params: valid_attributes }

      it 'creates a short url' do
        expect(json['short_url']).not_to be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end