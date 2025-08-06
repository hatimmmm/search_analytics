class RecordSearchJob < ApplicationJob
  queue_as :default

  def perform(query:, ip_address:)
    return if query.blank? || ip_address.blank?

    last_search = Search.where(ip_address: ip_address).order(created_at: :desc).first

    if last_search && last_search.created_at > Search::SESSION_WINDOW.ago
      if last_search.query == query
        return
      elsif query.start_with?(last_search.query) || last_search.query.start_with?(query)
        last_search.update!(query: query)
      else
        Search.create!(query: query, ip_address: ip_address)
      end
    else
      existing_exact_search = Search.where(ip_address: ip_address, query: query).first

      if existing_exact_search
        existing_exact_search.touch
      else
        Search.create!(query: query, ip_address: ip_address)
      end
    end
  end
end
