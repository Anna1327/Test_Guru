class AddColumnNumberToQuestions < ActiveRecord::Migration[6.1]
  def up
    add_column :questions, :number, :integer, default: 1
  end

  def down
    remove_column :questions, :number, :integer
  end
end
