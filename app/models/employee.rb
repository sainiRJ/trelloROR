class Employee < ApplicationRecord
  before_create :set_role_to_employee
  has_secure_password
  # belongs_to :manager
  # has_and_belongs_to_many :roles
  # has_many :tasks

  def set_role_to_employee
    self.role = 'employee'
  end
end
