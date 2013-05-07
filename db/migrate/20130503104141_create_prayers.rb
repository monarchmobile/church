class CreatePrayers < ActiveRecord::Migration
	def change
		create_table :prayers do |t|
			t.integer :duration 
			t.text :request 
			t.string :pray_for_first_name 
			t.string :pray_for_last_name
			t.integer :share_with
			t.integer :category

			t.timestamps

		end
	end
end
