class PagesController < ApplicationController
  def home
  end

  def analytics
    @top_searches = Search.where("length(query) > 2")
                          .group(:query)
                          .order("count_query DESC")
                          .limit(20)
                          .count(:query)

    # Fix: Include created_at in select since we're ordering by it
    @user_recent_searches = Search.where(ip_address: request.remote_ip)
                                  .select(:query, :created_at)
                                  .distinct
                                  .order(created_at: :desc)
                                  .limit(10)
  end
end
