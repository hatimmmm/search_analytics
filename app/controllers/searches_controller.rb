class SearchesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    Search.record(query: params[:query], ip_address: request.remote_ip)
    @articles = Article.search(params[:query]).limit(10)
    render json: @articles, status: :ok
  end
end
