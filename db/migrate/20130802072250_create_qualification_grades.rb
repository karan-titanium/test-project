class CreateQualificationGrades < ActiveRecord::Migration
  def change
    create_table :qualification_grades do |t|
      t.string :name
      t.string :status
      t.integer :qualification_type_id
      t.integer :order
      t.timestamps
    end
  end
end
