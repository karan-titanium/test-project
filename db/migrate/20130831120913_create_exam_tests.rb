class CreateExamTests < ActiveRecord::Migration
  def change
    create_table :exam_tests do |t|
      t.integer :exam_id
      t.integer :tfp_test_id
      t.integer :order
      
      t.timestamps
    end
  end
end
