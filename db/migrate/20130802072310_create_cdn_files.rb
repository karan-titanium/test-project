class CreateCdnFiles < ActiveRecord::Migration
  def change
    create_table :cdn_files do |t|

      t.integer :uploaded_by
      t.string :filename
      t.string :ext
      t.string :mimetype
      t.integer :size
      t.string :cf_filename
      t.string :file_type
      t.timestamps
    end
    add_index :cdn_files, :id, :unique => true
  end
end
