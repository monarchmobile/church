class AddAffiationIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :affiliation_id, :integer
    add_index :users, :affiliation_id
  end
end
