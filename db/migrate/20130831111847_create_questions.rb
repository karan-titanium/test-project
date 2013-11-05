class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :question_category_id
      t.string :name
      t.text :description
      t.string :status
      t.text :content
      t.text :explanation
      t.string :difficulty

      t.timestamps
    end
  end
end
