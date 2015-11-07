class AddColumnUserIdToVisitors < ActiveRecord::Migration
  def change
    add_reference :visitors, :user, index: true
  end
end
