class AddClergyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :clergy_first_name, :string
    add_column :users, :clergy_last_name, :string
    add_column :users, :clergy_email, :string
    add_column :users, :clergy_phone_number, :string
    add_column :users, :phone, :string
  end
end
