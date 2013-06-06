class CreateScriptures < ActiveRecord::Migration
	def change
		create_table :scriptures do |t|
			t.string :title
			t.text :content

			t.timestamps

		end
	end
end


