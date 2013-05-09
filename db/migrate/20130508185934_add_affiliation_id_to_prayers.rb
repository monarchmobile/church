class AddAffiliationIdToPrayers < ActiveRecord::Migration
  def change
    add_column :prayers, :affiliation_id, :integer
  end
end
