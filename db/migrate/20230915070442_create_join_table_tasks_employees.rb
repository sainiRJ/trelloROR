class CreateJoinTableTasksEmployees < ActiveRecord::Migration[7.0]
  def change
    create_join_table :tasks, :employees do |t|
      # t.index [:task_id, :employee_id]
      # t.index [:employee_id, :task_id]
    end
  end
end
