class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.string :mobile_number
      t.string :password_digest
      t.references :manager, null: false, foreign_key: true

      t.timestamps
    end
  end
end
