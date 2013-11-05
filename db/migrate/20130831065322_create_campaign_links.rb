class CreateCampaignLinks < ActiveRecord::Migration
  def change
    create_table :campaign_links do |t|
      t.integer :campaign_id
      t.string :name
      t.text :description
      t.string :status
      t.string :url      
      
      t.timestamps
    end
  end
end
