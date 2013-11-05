class CreateQualificationTypes < ActiveRecord::Migration
  def change
    create_table :qualification_types do |t|
      t.string :name
      t.string :status, :default => "unconfirmed"

      t.timestamps
    end
  end
end
