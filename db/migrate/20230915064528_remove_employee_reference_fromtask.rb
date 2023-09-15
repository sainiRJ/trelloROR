class RemoveEmployeeReferenceFromtask < ActiveRecord::Migration[7.0]
  def change
    remove_column :tasks, :employee_id, :bigint
  end
end
