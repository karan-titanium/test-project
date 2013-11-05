class CreateQuestionOptions < ActiveRecord::Migration
  def change
    create_table :question_options do |t|
      t.integer :question_part_id
      t.integer :order
      t.text :content
      t.integer :points
  
      t.timestamps
    end
  end
end
