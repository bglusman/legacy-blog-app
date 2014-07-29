class Category < ActiveRecord::Base
  validates :name, presence: true

  # Crazy stuff, just to bring coverage down
  before_save do
    self.name = self.name.mb_chars.upcase
  end
end
