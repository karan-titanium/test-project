class CreateTestQuestions < ActiveRecord::Migration
  def change
    create_table :test_questions do |t|
      t.integer :tfp_test_id
      t.integer :question_id
      t.integer :order

      t.timestamps
    end
  end
end
