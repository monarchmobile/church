class CreateAffiliations < ActiveRecord::Migration
	def change
		create_table :affiliations do |t|
			t.string :church
			t.string :city
			t.string :state

			t.timestamps

		end
	end
end