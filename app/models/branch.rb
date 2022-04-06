class Branch < ApplicationRecord
  validates :name, :address, presence: true
  validates :name, uniqueness: true

  has_many :employees
end
