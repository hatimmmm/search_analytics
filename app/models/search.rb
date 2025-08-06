class Search < ApplicationRecord
  validates :query, presence: true
  validates :ip_address, presence: true

  SESSION_WINDOW = 20.seconds

  def self.record(query:, ip_address:)
    return if query.blank? || ip_address.blank?

    cache_key = "last_search_query_for_#{ip_address}"
    last_query_from_cache = Rails.cache.read(cache_key)

    normalized_query = query.strip.downcase
    normalized_last_query = last_query_from_cache.to_s.strip.downcase

    return if normalized_last_query == normalized_query

    RecordSearchJob.perform_later(query: query, ip_address: ip_address)
    Rails.cache.write(cache_key, query, expires_in: SESSION_WINDOW)
  end
end
