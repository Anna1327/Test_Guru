class AddPublishedFieldToTest < ActiveRecord::Migration[6.1]
  def up
    add_column :tests, :published, :integer, default: 0
  end

  def down
    remove_column :tests, :published
  end
end
