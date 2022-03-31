class Branch < ApplicationRecord
  validates :name, uniqueness: true
  has_many :employees
end
