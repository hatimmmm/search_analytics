class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  scope :search, ->(query) {
          if query.present?
            where("LOWER(title) LIKE ? OR LOWER(content) LIKE ?", "%#{query.downcase}%", "%#{query.downcase}%")
          end
        }
end
