class AddCheckinTimeToMeeting < ActiveRecord::Migration
  def change
    add_column :meetings, :checkin_time, :time
    add_column :meetings, :checkout_time, :time
  end
end
