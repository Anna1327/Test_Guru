class AddColumnsRuleValueToBadge < ActiveRecord::Migration[6.1]
  def change
    add_column :badges, :rule, :string
    add_column :badges, :value, :string
    remove_column :badges, :condition, :json, if_exists: true
  end
end
