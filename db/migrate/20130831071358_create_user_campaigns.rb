class CreateUserCampaigns < ActiveRecord::Migration
  def change
    create_table :user_campaigns do |t|
      t.integer :user_id
      t.integer :campaign_id
      t.datetime :date
      t.datetime :date_forwarded
      t.datetime :date_reviewed
      t.integer :source_staff
      t.integer :source_link
      t.string :status
      t.datetime :phone_date
      t.string :phone_result
      t.text :phone_notes
      t.datetime :interview_date
      t.string :interview_result
      t.text :interview_notes
      
      t.timestamps
    end
  end
end
