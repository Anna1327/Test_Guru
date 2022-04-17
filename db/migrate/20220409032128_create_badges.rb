class CreateBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :badges do |t|
      t.string :title
      t.string :image_url
      t.json :condition, default: {}
      t.timestamps
    end
  end
end
