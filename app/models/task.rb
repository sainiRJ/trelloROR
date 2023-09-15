class Task < ApplicationRecord
  has_and_belongs_to_many :employees
  attr_accessor :employee_ids_to_add, :employee_ids_to_remove
  STATUS_OPTIONS = ['To Do', 'In Progress', 'Review', 'Done'].freeze
  validates :status, inclusion: { in: STATUS_OPTIONS }

end
