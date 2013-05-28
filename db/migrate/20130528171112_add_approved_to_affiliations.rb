class AddApprovedToAffiliations < ActiveRecord::Migration
  def change
    add_column :affiliations, :approved, :boolean, :default => false
  end
end
