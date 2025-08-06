class PagesController < ApplicationController
  def home
  end

  def analytics
    @top_searches = Search.where("length(query) > 2")
                          .group(:query)
                          .order("count_query DESC")
                          .limit(20)
                          .count(:query)

    @user_recent_searches = Search.where(ip_address: request.remote_ip)
                                  .order(created_at: :desc)
                                  .select(:query)
                                  .distinct
                                  .limit(10)
  end
end
