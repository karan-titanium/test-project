class CreateUserTraits < ActiveRecord::Migration
  def change
    create_table :user_traits do |t|
      t.integer :user_id
      t.integer :trait_id
      t.integer :score
      t.text :notes
      
      t.timestamps
    end
  end
end
