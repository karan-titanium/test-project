class CreateCampaignExams < ActiveRecord::Migration
  def change
    create_table :campaign_exams do |t|
      t.integer :campaign_id
      t.integer :exam_id
      t.string :stage            
      
      t.timestamps
    end
  end
end
