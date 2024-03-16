class Category < ApplicationRecord
  has_many :sub_categories

  validates :name, presence: true, uniqueness: true
end
