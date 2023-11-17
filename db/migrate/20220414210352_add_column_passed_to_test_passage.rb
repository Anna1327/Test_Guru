class AddColumnPassedToTestPassage < ActiveRecord::Migration[6.1]
  def change
    add_column :test_passages, :passed, :boolean, default: false
  end
end
