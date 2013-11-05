class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.string      :name
      t.text        :description
      t.string      :status, :default => 'draft'
      t.boolean     :generic
      t.text        :intro
      t.integer     :rest

      t.timestamps
    end
  end
end
