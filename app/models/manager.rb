class Manager < ApplicationRecord
    before_create :set_role_to_manager
    has_secure_password
    # has_many :employees
    attr_accessor :role

    # ROLES = %W{admin manager employee}

    def set_role_to_manager
        self.role = 'manager'
      end
end
