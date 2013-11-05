class CreateSettingCategories < ActiveRecord::Migration
  def change
    create_table :setting_categories do |t|
      t.string :name
      
      t.timestamps
    end
  end
end
