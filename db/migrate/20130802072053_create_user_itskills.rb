class CreateUserItskills < ActiveRecord::Migration
  def change
    create_table :user_itskills do |t|
      t.integer :user_id
      t.integer :itskill_id
      t.integer :experience
      t.string :level

      t.timestamps
    end
  end
end
