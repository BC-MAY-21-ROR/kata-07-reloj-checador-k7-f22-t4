class Employee < ApplicationRecord
  validates :private_code, length: { is: 6 }
  belongs_to :branch
  has_many :attendances

  def self.search(search)
    if search !=""
      employee = self.where(['name ILIKE ?', "%#{search}%"])
    else 
      Employee.order(:id).all
    end
  end

  def self.name_by_id(id)
    Employee.find_by(id: id).name
  end
end
