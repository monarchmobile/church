class AddScripturesToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :scripture_list, :string
  end
end
