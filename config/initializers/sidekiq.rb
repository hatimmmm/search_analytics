redis_config = {
  url: ENV.fetch("REDIS_URL", "redis://localhost:6379/1"),
}

# Handle SSL verification for production Redis (like Heroku Redis)
if ENV["REDIS_URL"]&.start_with?("rediss://")
  redis_config[:ssl_params] = { verify_mode: OpenSSL::SSL::VERIFY_NONE }
end

Sidekiq.configure_server do |config|
  config.redis = redis_config

  config.death_handlers << ->(job, ex) do
    Rails.logger.error "Job #{job["class"]} died: #{ex.message}"
  end
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end
