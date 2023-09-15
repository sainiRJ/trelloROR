class Task < ApplicationRecord
  belongs_to :employee
  # enum status: { draft: 0, submitted: 1, approved: 2, rejected: 3 }
end
