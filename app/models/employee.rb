class Employee < ApplicationRecord
  validates :private_code, length: { is: 6 }

  belongs_to :branch
  has_many :attendances
end
