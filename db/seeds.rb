puts "Destroying all articles..."
Article.destroy_all
puts "All articles destroyed."

puts "Creating articles..."

Article.create!([
  {
    title: "Getting Started with Ruby on Rails",
    content: "Ruby on Rails is a powerful web application framework. This guide covers the basics of creating your first application, including models, views, and controllers.",
  },
  {
    title: "Understanding Stimulus JS",
    content: "Stimulus is a modest JavaScript framework for the HTML you already have. It makes it easy to add dynamic behavior to your pages without a heavy frontend library.",
  },
  {
    title: "A Guide to Tailwind CSS",
    content: "Tailwind CSS is a utility-first CSS framework for rapidly building custom user interfaces. Learn how to use utilities for spacing, typography, and color.",
  },
  {
    title: "The Power of PostgreSQL",
    content: "PostgreSQL offers advanced features like full-text search, JSONB data types, and robust indexing. It's a great choice for scalable Rails applications.",
  },
  {
    title: "Testing with RSpec in Rails",
    content: "RSpec is a testing tool for Ruby, created for behavior-driven development (BDD). It is the most frequently used testing library for Ruby on Rails.",
  },
  {
    title: "Deploying Rails Apps to Heroku",
    content: "Heroku is a cloud platform that enables companies to build, run, and operate applications entirely in the cloud. Learn how to deploy your Rails app step by step.",
  },
  {
    title: "Redis for Caching and Background Jobs",
    content: "Redis is an in-memory data structure store, used as a database, cache, and message broker. Discover how to integrate Redis with Rails for better performance.",
  },
  {
    title: "Active Job and Sidekiq Integration",
    content: "Active Job is a framework for declaring jobs and making them run on a variety of queuing backends. Sidekiq is a popular choice for processing background jobs in Rails.",
  },
  {
    title: "Building RESTful APIs with Rails",
    content: "Learn how to create robust RESTful APIs using Ruby on Rails. This guide covers serialization, authentication, versioning, and best practices for API design.",
  },
  {
    title: "Database Migrations and Schema Design",
    content: "Migrations are a feature of Active Record that allows you to evolve your database schema over time. Learn best practices for writing and managing migrations.",
  },
  {
    title: "Authentication with Devise",
    content: "Devise is a flexible authentication solution for Rails based on Warden. It provides a complete MVC solution based on Rails engines.",
  },
  {
    title: "Authorization with Pundit",
    content: "Pundit provides a set of helpers which guide you in leveraging regular Ruby classes and object oriented design patterns to build a simple, robust authorization system.",
  },
  {
    title: "Advanced Active Record Queries",
    content: "Master complex database queries using Active Record. Learn about joins, includes, scopes, and performance optimization techniques.",
  },
  {
    title: "Building Real-time Features with Action Cable",
    content: "Action Cable seamlessly integrates WebSockets with the rest of your Rails application. Learn how to build real-time features like chat and notifications.",
  },
  {
    title: "File Uploads with Active Storage",
    content: "Active Storage facilitates uploading files to a cloud storage service like Amazon S3, Google Cloud Storage, or Microsoft Azure Storage and attaching those files to Active Record objects.",
  },
  {
    title: "Internationalization (i18n) in Rails",
    content: "The Ruby I18n gem provides a flexible framework for translating your application to multiple languages. Learn how to implement multi-language support.",
  },
  {
    title: "Performance Optimization Techniques",
    content: "Discover various techniques to optimize your Rails application performance, including database optimization, caching strategies, and code profiling.",
  },
  {
    title: "Security Best Practices in Rails",
    content: "Learn about common security vulnerabilities and how to protect your Rails application from threats like SQL injection, XSS, and CSRF attacks.",
  },
  {
    title: "Docker and Rails Development",
    content: "Containerize your Rails application with Docker. Learn how to set up development environments, manage dependencies, and deploy containerized applications.",
  },
  {
    title: "GraphQL with Rails",
    content: "GraphQL is a query language for APIs that provides a complete description of the data in your API. Learn how to implement GraphQL in your Rails application.",
  },
  {
    title: "Microservices Architecture with Rails",
    content: "Explore how to break down monolithic Rails applications into microservices. Learn about service communication, data consistency, and deployment strategies.",
  },
  {
    title: "Email Processing with Action Mailer",
    content: "Action Mailer allows you to send emails from your application using mailer classes and views. Learn how to configure and send various types of emails.",
  },
  {
    title: "Background Processing Patterns",
    content: "Learn different patterns for handling background jobs in Rails applications, including job queues, retry strategies, and monitoring job performance.",
  },
  {
    title: "Rails Engine Development",
    content: "Rails Engines provide a way to wrap up functionality and share it across different Rails applications. Learn how to build and distribute your own engines.",
  },
  {
    title: "Advanced Routing Techniques",
    content: "Master Rails routing with advanced techniques including nested resources, custom constraints, subdomain routing, and route optimization.",
  },
  {
    title: "Asset Pipeline and Webpacker",
    content: "Understand how Rails handles static assets through the asset pipeline and modern JavaScript bundling with Webpacker for complex frontend needs.",
  },
  {
    title: "Monitoring and Logging in Production",
    content: "Learn how to effectively monitor your Rails application in production using tools like New Relic, Datadog, and structured logging practices.",
  },
  {
    title: "Database Indexing Strategies",
    content: "Optimize your database performance with proper indexing strategies. Learn about different index types, when to use them, and how to monitor index usage.",
  },
  {
    title: "Rails Configuration Management",
    content: "Master Rails configuration using environment variables, Rails credentials, and different configuration patterns for various deployment environments.",
  },
  {
    title: "Custom Validators and Form Objects",
    content: "Build robust data validation using custom Active Record validators and form objects to encapsulate complex form logic outside of your models.",
  },
  {
    title: "Service Objects and Design Patterns",
    content: "Learn how to organize complex business logic using service objects, form objects, and other design patterns to keep your Rails applications maintainable.",
  },
  {
    title: "Rails and Single Page Applications",
    content: "Explore how to use Rails as an API backend for single-page applications built with React, Vue.js, or other frontend frameworks.",
  },
  {
    title: "Advanced Git Workflows for Rails Teams",
    content: "Master Git workflows for Rails development teams including feature branches, code reviews, continuous integration, and deployment strategies.",
  },
  {
    title: "Rails Application Architecture",
    content: "Learn about different architectural patterns for Rails applications including MVC variations, hexagonal architecture, and domain-driven design.",
  },
  {
    title: "Testing Strategies and Test-Driven Development",
    content: "Comprehensive guide to testing Rails applications covering unit tests, integration tests, system tests, and test-driven development practices.",
  },
  {
    title: "Rails 7 New Features and Upgrades",
    content: "Explore the latest features in Rails 7 including Hotwire, import maps, and other improvements. Learn how to upgrade from previous versions.",
  },
  {
    title: "Database Sharding and Scaling",
    content: "Learn advanced database scaling techniques including read replicas, database sharding, and horizontal scaling strategies for large Rails applications.",
  },
  {
    title: "Rails and Machine Learning Integration",
    content: "Discover how to integrate machine learning models into your Rails applications using libraries like scikit-learn, TensorFlow, and cloud ML services.",
  },
  {
    title: "Progressive Web Apps with Rails",
    content: "Build progressive web applications using Rails as the backend. Learn about service workers, offline functionality, and mobile app-like experiences.",
  },
  {
    title: "Rails Console Tips and Tricks",
    content: "Master the Rails console with advanced tips and tricks for debugging, data manipulation, and development workflow optimization.",
  },
  {
    title: "Custom Rake Tasks and Automation",
    content: "Learn how to create custom Rake tasks for automating repetitive tasks, data migrations, and maintenance operations in your Rails applications.",
  },
  {
    title: "Rails and Elasticsearch Integration",
    content: "Implement powerful search functionality in your Rails application using Elasticsearch. Learn about indexing, querying, and search optimization.",
  },
  {
    title: "Memory Management and Garbage Collection",
    content: "Understand Ruby's memory management and garbage collection. Learn how to profile memory usage and optimize your Rails application's memory footprint.",
  },
  {
    title: "Rails Concerns and Code Organization",
    content: "Learn how to use Rails concerns effectively to share code between models and controllers while maintaining clean, organized codebases.",
  },
  {
    title: "Advanced Active Storage Techniques",
    content: "Deep dive into Active Storage with advanced techniques for file processing, image variants, direct uploads, and cloud storage optimization.",
  },
  {
    title: "Rails and Payment Processing",
    content: "Integrate payment processing into your Rails application using Stripe, PayPal, and other payment gateways. Learn about security and PCI compliance.",
  },
  {
    title: "Building Multi-tenant Applications",
    content: "Learn different approaches to building multi-tenant Rails applications including row-level security, schema separation, and database-per-tenant strategies.",
  },
  {
    title: "Rails Performance Monitoring",
    content: "Set up comprehensive performance monitoring for your Rails applications using APM tools, custom metrics, and performance budgets.",
  },
  {
    title: "Advanced CSS and Sass in Rails",
    content: "Master advanced CSS techniques in Rails applications including CSS Grid, Flexbox, custom properties, and Sass mixins for maintainable stylesheets.",
  },
  {
    title: "Rails and WebRTC for Real-time Communication",
    content: "Build real-time communication features like video calls and screen sharing in your Rails application using WebRTC and Action Cable.",
  },
  {
    title: "Database Connection Pooling and Optimization",
    content: "Optimize database connections in your Rails application with connection pooling, connection management, and database performance tuning.",
  },
])

puts "Finished creating #{Article.count} articles."
