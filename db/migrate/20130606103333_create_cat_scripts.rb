class CreateCatScripts < ActiveRecord::Migration
	def change
		create_table :cats_scripts do |t|
			t.references :category, :scripture
		end
	end
end