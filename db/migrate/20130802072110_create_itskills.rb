class CreateItskills < ActiveRecord::Migration
  def change
    create_table :itskills do |t|
      t.string :name
      t.string :status, :default => "unconfirmed"

      t.timestamps
    end
  end
end
