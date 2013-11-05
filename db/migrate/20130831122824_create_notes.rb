class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :table
      t.string :table_col
      t.integer :table_id
      t.integer :user_id
      t.text :note
      
      t.timestamps
    end
  end
end
