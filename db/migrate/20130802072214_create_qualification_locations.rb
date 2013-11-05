class CreateQualificationLocations < ActiveRecord::Migration
  def change
    create_table :qualification_locations do |t|
      t.string :name
      t.string :status, :default => "unconfirmed" 

      t.timestamps
    end
  end
end
