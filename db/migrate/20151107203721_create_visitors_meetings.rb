class CreateVisitorsMeetings < ActiveRecord::Migration
  def change
    create_table :visitors_meetings do |t|
      t.references :visitor, index: true
      t.references :meeting, index: true

      t.timestamps null: false
    end
  end
end
