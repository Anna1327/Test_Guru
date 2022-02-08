class AddColNameInUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    remove_column :users, :firstName, :string, if_exists: true
    remove_column :users, :lastName, :string, if_exists: true
  end
end
