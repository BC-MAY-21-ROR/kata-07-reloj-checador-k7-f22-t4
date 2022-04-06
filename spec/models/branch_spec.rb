require 'rails_helper'

describe Branch do
  before(:each) do
    @branch = Branch.new(name: 'Recursos humanos', address: 'V. Carranza')
  end

  it 'is valid create with all fields values' do
    expect(@branch).to be_valid
  end

  it 'Name field should have presence' do
    @branch.name = nil
    expect(@branch).not_to be_valid
  end

  it 'Address field should have presence' do
    @branch.address = nil
    expect(@branch).not_to be_valid
  end

  it 'Branch name must be unique' do
    @branch.save!
    branch2 = Branch.new(name: 'Recursos humanos', address: 'Manzanillo, Colima')
    expect(branch2).not_to be_valid
  end
end
