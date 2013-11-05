class CreateTfpTests < ActiveRecord::Migration
  def change
    create_table :tfp_tests do |t|
      t.string :name
      t.string :description
      t.string :status
      t.integer :duration
      t.integer :example
      
      t.timestamps
    end
  end
end
