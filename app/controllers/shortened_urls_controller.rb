class ShortenedUrlsController < ApplicationController
before_action :find_url, only: [:show]
before_action :ensure_params_exist, only: [:create]

  def index
    @urls = ShortenedUrl.all 
    render json: @urls
  end

  def show
    render json: {url: @url.sanitize_url}
  end

  def create
    @url = ShortenedUrl.new
    @url.original_url = params[:original_url]
    @url.sanitize
    if @url.new_url?
      @url = ShortenedUrl.create!(url_params)
      render json: {short_url: @url.short_url}
    else
      render json: {status: 'Already in our db'}
    end
  end

  def fetch_original_url
    fetch_url = ShortenedUrl.find_by_short_url(params[:short_url])
    redirect_to fetch_url.sanitize_url
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
    render :json => {:success=>false, :message=>"missing original_url parameter"}, :status=>422
  end

end