class AddSendAtToAnnouncements < ActiveRecord::Migration
  def change
    add_column :announcements, :send_at, :date
  end
end
