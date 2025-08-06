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
])

puts "Finished creating #{Article.count} articles."
