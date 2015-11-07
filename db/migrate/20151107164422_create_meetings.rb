class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.references :visitor, index: true
      t.time :start_time
      t.time :end_time
      t.date :date
      t.text :description
      t.string :venue
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
