class CreateQualificationSubjects < ActiveRecord::Migration
  def change
    create_table :qualification_subjects do |t|
      t.string :name
      t.string :status, :default => "unconfirmed"

      t.timestamps
    end
  end
end
