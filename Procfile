release: npm run build:css && rails assets:precompile && rails db:migrate
web: bundle exec rails server -p $PORT -e $RAILS_ENV
worker: bundle exec sidekiq
