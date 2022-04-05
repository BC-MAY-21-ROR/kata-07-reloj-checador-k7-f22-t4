class Branch < ApplicationRecord
  has_many :employees

  def self.search(search)
    if search !=""
      brach = self.where(['name ILIKE ?', "%#{search}%"])
    else 
      Branch.order(:id).all
    end
  end
end
