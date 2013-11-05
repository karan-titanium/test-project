class CreateCampaignTraits < ActiveRecord::Migration
  def change
    create_table :campaign_traits do |t|
      t.integer :campaign_id
      t.integer :trait_id
      t.integer :weight
      
      t.timestamps
    end
  end
end
