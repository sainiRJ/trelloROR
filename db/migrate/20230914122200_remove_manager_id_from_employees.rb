class RemoveManagerIdFromEmployees < ActiveRecord::Migration[7.0]
  def change
    remove_column :employees, :manager_id, :bigint
  end
end
