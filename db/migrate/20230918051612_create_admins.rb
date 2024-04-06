class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins do |t|
      t.string :name
      t.string :email
      t.string :mobile_number
      t.string :password_digest

      t.timestamps
    end
  end
end
