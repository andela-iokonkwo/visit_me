class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :provider
      t.string :token
      t.string :uid
      t.string :role

      t.timestamps null: false
    end
  end
end
