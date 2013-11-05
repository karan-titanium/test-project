class CreateCampaignLinkClicks < ActiveRecord::Migration
  def change
    create_table :campaign_link_clicks do |t|
      t.integer :campaign_link_id
      t.datetime :date
      t.string :referrer
      t.boolean :unique
      
      t.timestamps
    end
  end
end
