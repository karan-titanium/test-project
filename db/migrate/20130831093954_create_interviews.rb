class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.datetime :date
      t.integer :candidate
      t.integer :interviewer
      t.integer :campaign
      t.string :interview_type
      t.text :notes
      t.integer :audiofile
      t.integer :transcript
      
      t.timestamps
    end
  end
end
