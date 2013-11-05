class CreateUserExams < ActiveRecord::Migration
  def change
    create_table :user_exams do |t|
      t.integer :user_id
      t.integer :exam_id
      t.string :status
      t.datetime :date_start
      t.datetime :date_end
      
      t.timestamps
    end
  end
end
