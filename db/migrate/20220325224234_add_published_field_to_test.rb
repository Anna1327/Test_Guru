class AddPublishedFieldToTest < ActiveRecord::Migration[6.1]
  def change
    add_column :tests, :published, :boolean, default: false
  end
end
