class Post < ActiveRecord::Base
  belongs_to :category
  has_many   :comments

  validates :title, :body, presence: true

  # This will look like it has been used
  scope :not_highlighted, -> { where(highlighted: false) }

  # But this won't because there is a line break
  scope :highlighted, -> {
    where(highlighted: true)
  }
end
