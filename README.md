# HelpJuice Search Analytics

A real-time search application with analytics built using Ruby on Rails 8 and Stimulus.js. This application provides instant search functionality for articles while tracking and analyzing search patterns.

## Features

- **Real-time Search**: Type-ahead search functionality using Stimulus.js with debounced input
- **Search Analytics**: Track and display search patterns and popular queries
- **Smart Deduplication**: Prevents recording duplicate searches within a configurable session window
- **Redis Caching**: Uses Redis for efficient caching of recent searches to prevent spam
- **Background Processing**: Asynchronous search recording using Active Job with Sidekiq
- **Responsive Design**: Mobile-friendly interface built with Tailwind CSS

## Tech Stack

- **Backend**: Ruby on Rails 8.0
- **Frontend**: Stimulus.js, Tailwind CSS
- **Database**: SQLite (development), PostgreSQL (production)
- **Cache/Session Store**: Redis
- **Background Jobs**: Sidekiq
- **Testing**: RSpec with comprehensive test coverage

## Prerequisites

- Ruby 3.3+
- Node.js 18+
- Redis server
- SQLite3 (development)
- PostgreSQL (production)

## Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd search_analytics
   ```

2. **Install dependencies**

   ```bash
   bundle install
   npm install
   ```

3. **Start Redis**

   ```bash
   # On macOS with Homebrew
   brew services start redis

   # On Ubuntu/Debian
   sudo systemctl start redis-server

   # Or run directly
   redis-server
   ```

4. **Setup database**

   ```bash
   bin/rails db:create
   bin/rails db:migrate
   bin/rails db:seed
   ```

5. **Build assets**

   ```bash
   npm run build:css
   npm run build
   ```

6. **Start the application**

   ```bash
   # Terminal 1: Rails server
   bin/rails server

   # Terminal 2: Background jobs
   bundle exec sidekiq
   ```

7. **Visit the application**
   - Home page: http://localhost:3000
   - Analytics: http://localhost:3000/analytics
   - Sidekiq dashboard: http://localhost:3000/sidekiq

## Usage

### Search Functionality

1. Navigate to the home page
2. Type in the search box to get real-time results
3. Results are fetched from the articles table using case-insensitive matching
4. Each unique search is tracked for analytics (with deduplication)

### Analytics Dashboard

- **Top Searches**: View the 20 most popular search queries across all users
- **Recent Searches**: See your personal search history based on IP address
- **Search Patterns**: Track how users interact with the search functionality

## How It Works

### Search Flow

1. User types in the search box (handled by Stimulus SearchController)
2. Input is debounced (300ms) to prevent excessive API calls
3. Frontend sends AJAX POST request to `/searches`
4. `Search.record()` method checks Redis cache for recent searches from the same IP
5. If not a duplicate within the session window, enqueues `RecordSearchJob`
6. Background job processes and stores search data with smart deduplication
7. Search results are returned from the Article model

### Deduplication Logic

The application implements intelligent search deduplication:

- **Cache-based Prevention**: Recent searches are cached in Redis with IP-based keys
- **Session Window**: 20 seconds (configurable via `Search::SESSION_WINDOW`)
- **Case-insensitive Matching**: "Rails" and "rails" are treated as the same query
- **Whitespace Normalization**: Leading/trailing spaces are ignored
- **Query Evolution**: If a user types "rail" then "rails", the record is updated rather than creating a new one
- **Exact Match Detection**: Duplicate exact queries update the timestamp instead of creating new records

### Background Job Processing

```ruby
# RecordSearchJob handles three scenarios:
# 1. Within session window + query evolution → Update existing record
# 2. Within session window + different query → Create new record
# 3. Outside session window + exact match → Update timestamp
# 4. Outside session window + new query → Create new record
```

## Configuration

### Cache Settings

```ruby
# config/application.rb
config.cache_store = :redis_cache_store, {
  url: ENV.fetch("REDIS_URL", "redis://localhost:6379/1")
}
```

### Session Window

```ruby
# app/models/search.rb
SESSION_WINDOW = 20.seconds
```

### Background Jobs

```ruby
# config/application.rb
config.active_job.queue_adapter = :sidekiq
```

## API Endpoints

- `POST /searches` - Record search and return results
- `GET /` - Home page with search interface
- `GET /analytics` - Analytics dashboard
- `GET /sidekiq` - Sidekiq web interface (development)

## Database Schema

### Articles

```ruby
create_table "articles" do |t|
  t.string "title", null: false
  t.text "content", null: false
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
end
```

### Searches

```ruby
create_table "searches" do |t|
  t.string "query", null: false
  t.string "ip_address", null: false
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
end
```

## Testing

Run the full test suite:

```bash
bundle exec rspec
```

Run specific test files:

```bash
bundle exec rspec spec/models/search_spec.rb
bundle exec rspec spec/jobs/record_search_job_spec.rb
bundle exec rspec spec/controllers/searches_controller_spec.rb
```

### Test Coverage

- **Models**: Search validation and recording logic
- **Jobs**: Background job processing and deduplication
- **Controllers**: API endpoints and response handling
- **Integration**: Full search workflow testing

## Environment Variables

```bash
# Required for production
DATABASE_URL=postgresql://user:password@host:port/database
REDIS_URL=redis://localhost:6379/1
SECRET_KEY_BASE=your_secret_key_base

# Optional
RAILS_ENV=production
RAILS_LOG_LEVEL=info
WEB_CONCURRENCY=2
RAILS_MAX_THREADS=5
```

## Deployment

### Using Kamal (Recommended)

```bash
# Setup secrets
kamal setup

# Deploy
kamal deploy
```

### Manual Deployment

1. Set environment variables
2. Run `bundle exec rails db:migrate`
3. Run `bundle exec rails db:seed`
4. Start Rails server and Sidekiq worker
5. Ensure Redis is running and accessible

## Performance Considerations

- **Database Indexing**: Add indexes on `searches.query` and `searches.ip_address` for large datasets
- **Redis Memory**: Monitor Redis memory usage as search cache grows
- **Background Jobs**: Scale Sidekiq workers based on search volume
- **CDN**: Use CDN for static assets in production

## Development

### Adding New Features

1. Follow Rails conventions for MVC structure
2. Add comprehensive tests for new functionality
3. Update this documentation
4. Use Stimulus controllers for frontend interactions

### Code Style

- Follow Rails best practices
- Use RuboCop for code formatting
- Write descriptive commit messages
- Add comments for complex business logic

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass
5. Submit a pull request

## License

This project is part of the HelpJuice Full-Stack Rails & Vanilla JS Internship Test.
