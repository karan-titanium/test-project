class CreateUserFiles < ActiveRecord::Migration
  def change
    create_table :user_files do |t|
      t.integer :user_id
      t.string :user_file_type
      t.integer :cdn_file_id

      t.timestamps
    end
  end
end
