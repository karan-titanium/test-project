class CreateSystemSettings < ActiveRecord::Migration
  def change
    create_table :system_settings do |t|
      t.string :key
      t.string :name
      t.string :description
      t.text :value
      t.string :setting_type
      t.boolean :editable
      t.integer :setting_category_id 

      t.timestamps
    end
  end
end
