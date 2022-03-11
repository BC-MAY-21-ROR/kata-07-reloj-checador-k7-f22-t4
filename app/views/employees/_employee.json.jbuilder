json.extract! employee, :id, :name, :email, :position, :private_code, :active, :branch_id, :created_at, :updated_at
json.url employee_url(employee, format: :json)
