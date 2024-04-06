class RemoveRoleFromManagers < ActiveRecord::Migration[7.0]
  def change
    remove_column :managers, :role, :string
  end
end
