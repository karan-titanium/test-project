class CreateQuestionParts < ActiveRecord::Migration
  def change
    create_table :question_parts do |t|
      t.integer :question_id
      t.integer :order
      t.text :content
      t.string :question_part_type
      
      t.timestamps
    end
  end
end
