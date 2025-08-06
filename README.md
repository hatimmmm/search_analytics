# HelpJuice Search Analytics

Helpjuice Full-Stack (Rails & Vanilla JS)
Internship Test

## Features

- **Realtime Search**: Type-ahead search functionality using Stimulus.js
- **Search Analytics**: Track and display search patterns and popular queries
- **Smart Deduplication**: Prevents recording duplicate searches within a session window (can be adjusted as needed)
- **Redis Caching**: Uses Redis for efficient caching of recent searches
- **Background Processing**: Asynchronous search recording using active aob with sidekiq

## Tech Stack

- **Backend**: Ruby on Rails 8.0
- **Frontend**: Stimulus.js, Tailwind CSS
- **Database**: SQLite (development), PostgreSQL (production)
- **Cache**: Redis
- **Background Jobs**: Sidekiq
- **Testing**: RSpec

## Setup

### Prerequisites

- Ruby 3.3+
- Node.js 18+
- Redis server
- SQLite3

### Installation

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

5. **Start the application**

   ```bash
   # Terminal 1: Rails server
   bin/rails server

   # Terminal 2: Background jobs
   bundle exec sidekiq

   # Terminal 3: Asset compilation (if needed)
   npm run build:css
   ```

6. **Visit the application**
   - Home page: http://localhost:3000
   - Analytics: http://localhost:3000/analytics

## Usage

### Search Functionality

- Type in the search box to get real-time results
- Results are fetched from the `articles` table
- Each search is tracked for analytics

### Analytics Dashboard

- View top 20 most popular searches
- See your recent search history (based on IP address)
- Track search patterns over time

## How It Works

### Search Flow

1. User types in search box (Stimulus controller)
2. Frontend sends AJAX request to `/searches`
3. `Search.record()` checks Redis cache for recent searches
4. If not a duplicate, enqueues `RecordSearchJob`
5. Background job processes and stores search data
6. Returns search results from articles

### Deduplication Logic

- Searches are cached in Redis with IP-based keys
- Session window: 20 seconds (configurable)
- Case-insensitive and whitespace-insensitive matching
- Prevents spam and improves analytics quality

## Configuration

### Cache Settings

```ruby
config.cache_store = :redis_cache_store, {
  url: ENV.fetch("REDIS_URL", "redis://localhost:6379/1")
}
```

### Session Window

```ruby
SESSION_WINDOW = 20.seconds
```

## API Endpoints

- `POST /searches` - Record search and return results
- `GET /` - Home page with search interface
- `GET /analytics` - Analytics dashboard

## Testing

```bash
bundle exec rspec

bundle exec rspec spec/models/search_spec.rb
bundle exec rspec spec/jobs/record_search_job_spec.rb
```

## Database Schema

### Articles

- `title` (string) - Article title
- `content` (text) - Article content

### Searches

- `query` (string) - Search query
- `ip_address` (string) - User's IP address
- `created_at` (datetime) - When search was performed

## Environment Variables

```bash
REDIS_URL=redis://localhost:6379/1
RAILS_ENV=production
SECRET_KEY_BASE=your_secret_key
```
