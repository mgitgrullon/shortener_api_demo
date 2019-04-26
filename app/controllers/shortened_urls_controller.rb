class ShortenedUrlsController < ApplicationController
  before_action :find_url, only: [:show]
  before_action :ensure_params_exist, only: [:create]

  def top
    @urls = ShortenedUrl.limit(10).order(counter: :desc)
    render json: @urls
  end

  def show
    render json: { url: @url.sanitize_url }
  end

  def create
    @url = ShortenedUrl.new
    @url.original_url = params[:original_url]
    @url.sanitize

    # check if shortened url exist in the db before create
    @duplicate_entry = @url.find_duplicate
    if @duplicate_entry.nil?
      if @url.save
        render json: { success: true, short_url: @url.short_url }
      else
        render json: { success: false, message: 'Invalid url' }
      end
    else
      @url = @duplicate_entry
      @url.increment_counter
      render json: { success: true, short_url: @url.short_url }
    end
  end

  def fetch_original_url
    fetch_url = ShortenedUrl.find_by_short_url(params[:short_url])
    fetch_url.present? redirect_to fetch_url.sanitize_url
  end

  protected

  def find_url
    @url = ShortenedUrl.find_by_short_url(params[:short_url])
  end

  def url_params
    params.permit(:original_url)
  end

  def ensure_params_exist
    return unless params[:original_url].blank?

    render json: { success: false, message: 'Missing original_url parameter' },
           status: 422
  end
end
