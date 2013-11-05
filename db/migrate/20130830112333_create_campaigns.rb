class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.datetime :date_activated
      t.datetime :date_inactive
      t.string :campaign_name
      t.string :reference
      t.string :status
      t.integer :company_id
      t.string :title
      t.text :summary
      t.text :details
      t.datetime :deadline_application
      t.datetime :deadline_forward
      
      t.timestamps
    end
  end
end
