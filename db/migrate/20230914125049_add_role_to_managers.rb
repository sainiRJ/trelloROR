class AddRoleToManagers < ActiveRecord::Migration[7.0]
  def change
    add_column :managers, :role, :string
  end
end
