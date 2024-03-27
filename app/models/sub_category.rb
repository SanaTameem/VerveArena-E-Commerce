class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :products, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :category_id, presence: true
end
