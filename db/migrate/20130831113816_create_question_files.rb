class CreateQuestionFiles < ActiveRecord::Migration
  def change
    create_table :question_files do |t|
       t.integer :question_id
      t.integer :cdn_file_id
      t.integer :order
      t.string  :title
      t.integer :image
      
      t.timestamps
    end
  end
end
