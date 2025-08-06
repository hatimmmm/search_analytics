redis_url = ENV.fetch("REDIS_URL", "redis://localhost:6379/1")

# Railway sometimes provides Redis URLs with different formats
# Ensure we use the correct URL format

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url }

  # Optional: Configure death handlers for failed jobs
  config.death_handlers << ->(job, ex) do
    Rails.logger.error "Job #{job["class"]} died: #{ex.message}"
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url }
end
