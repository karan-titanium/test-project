class CreateContactAttachments < ActiveRecord::Migration
  def change
    create_table :contact_attachments do |t|
      t.integer :contact_log_id
      t.boolean :private
      t.integer :cdn_file_id
      
      t.timestamps
    end
  end
end
