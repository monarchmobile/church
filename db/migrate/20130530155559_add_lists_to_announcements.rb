class AddListsToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :send_list, :string
    add_column :announcements, :sent, :boolean, :default => false
    add_column :announcements, :show_list, :string
  end
end
