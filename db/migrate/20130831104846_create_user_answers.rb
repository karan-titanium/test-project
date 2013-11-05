class CreateUserAnswers < ActiveRecord::Migration
  def change
    create_table :user_answers do |t|
      t.integer :sitting
      t.datetime :date
      t.integer :test_id
      t.integer :question_option_id
      t.text :answer
      t.integer :points
      
      t.timestamps
    end
  end
end
