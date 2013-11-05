class CreateQuestionCategories < ActiveRecord::Migration
  def change
    create_table :question_categories do |t|
      t.string :name
      t.integer :trait_id
      t.string :status
      t.timestamps
    end
  end
end
