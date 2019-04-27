class ShortenedUrlsController < ApplicationController
  before_action :find_url, only: [:show]
  before_action :ensure_params_exist, only: [:create]

  # GET /top
  def top
    @urls = ShortenedUrl.limit(100).order(counter: :desc)
    render json: @urls
  end

  # GET sanitize/:short_url
  def show
    render json: { url: @url.sanitize_url }
  end

  # POST /short_it
  def create
    @url = ShortenedUrl.new
    @url.original_url = params[:original_url]
    @url.sanitize

    # check if shortened url exist in the db before create
    @duplicate_entry = @url.find_duplicate
    if @duplicate_entry.nil?
      if @url.save
        render json: { success: true, short_url: host_url(@url) }
      else
        render json: { success: false, message: 'Invalid url' }
      end
    else
      render json: { success: true, short_url: host_url(@duplicate_entry) }
    end
  end

  # GET /:short_url
  def fetch_original_url
    fetch_url = ShortenedUrl.find_by_short_url(params[:short_url])
    if fetch_url.present?
      fetch_url.increment!(:counter)
      redirect_to fetch_url.sanitize_url
    else
      render json: { success: false, message: 'Invalid url' }
    end
  end

  protected

  def host_url(url)
    request.host_with_port + '/' + url.short_url
  end

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
