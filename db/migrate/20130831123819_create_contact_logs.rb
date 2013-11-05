class CreateContactLogs < ActiveRecord::Migration
  def change
    create_table :contact_logs do |t|
      t.integer :from
      t.integer :to
      t.integer :campaign_id
      t.string :method
      t.datetime :datecontact
      t.text :subject
      t.text :details
      
      t.timestamps
    end
  end
end
