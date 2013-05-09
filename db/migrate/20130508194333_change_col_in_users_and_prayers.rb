class ChangeColInUsersAndPrayers < ActiveRecord::Migration
  def up
  	remove_column :users, :affiliation
  	remove_column :prayers, :affiliation_id
  	add_column :prayers, :user_id, :integer
  end

  def down
  end
end
