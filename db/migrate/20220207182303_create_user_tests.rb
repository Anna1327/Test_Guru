class CreateUserTests < ActiveRecord::Migration[6.1]
  def up
    create_table :user_tests do |t|
      t.integer :score
      t.references :test, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end

  def down
    drop_table :user_tests, if_exists: true
  end
end
