class CreateTranscriptRequests < ActiveRecord::Migration
  def change
    create_table :transcript_requests do |t|
      t.integer :user_id
      t.integer :interview_id
      t.datetime :notified
      
      t.timestamps
    end
  end
end
