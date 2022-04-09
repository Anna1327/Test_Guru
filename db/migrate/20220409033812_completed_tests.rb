class CompletedTests < ActiveRecord::Migration[6.1]
  def change
    create_table :completed_tests do |t|  
      t.references :test, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :passed, default: false
      t.integer :attempts, default: 0
    end
  end
end
