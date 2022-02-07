class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :firstName, null: false
      t.string :lastName
      t.string :role
      t.timestamps
    end
  end
end
