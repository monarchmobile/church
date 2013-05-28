class AddWeCareToPrayers < ActiveRecord::Migration
  def change
    add_column :prayers, :we_care, :boolean, :default => false
  end
end
