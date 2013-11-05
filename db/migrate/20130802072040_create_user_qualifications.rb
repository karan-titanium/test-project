class CreateUserQualifications < ActiveRecord::Migration
  def change
    create_table :user_qualifications do |t|
      t.integer :user_id
      t.integer :qualification_type_id
      t.integer :qualification_location_id
      t.integer :qualification_subject_id
      t.integer :qualification_grade_id
      t.integer :year

      t.timestamps
    end
  end
end
