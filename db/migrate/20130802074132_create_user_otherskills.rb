class CreateUserOtherskills < ActiveRecord::Migration
  def change
    create_table :user_otherskills do |t|
      t.integer :user_id
      t.string :skill
      t.integer :experience
      t.string :level

      t.timestamps
    end
  end
end
