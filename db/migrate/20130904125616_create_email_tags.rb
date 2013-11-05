class CreateEmailTags < ActiveRecord::Migration
  def change
    create_table :email_tags do |t|
      t.string :name
      t.string :tag

      t.timestamps
    end
  end
end
