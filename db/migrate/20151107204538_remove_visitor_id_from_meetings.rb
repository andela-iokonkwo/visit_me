class RemoveVisitorIdFromMeetings < ActiveRecord::Migration
  def change
    remove_column :meetings, :visitor_id
  end
end
