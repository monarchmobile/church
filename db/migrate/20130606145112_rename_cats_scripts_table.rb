class RenameCatsScriptsTable < ActiveRecord::Migration
  def self.up
    rename_table :cats_scripts, :categories_scriptures
  end

 def self.down
    rename_table :categories_scriptures, :cats_scripts
 end
end
