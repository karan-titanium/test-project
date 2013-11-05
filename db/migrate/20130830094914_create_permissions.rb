class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :name
      t.text :description
      t.string :subject_class # model names like User, Role, Book, Author
      t.string :action  # controller action like new, create or destroy
      
      t.timestamps
    end
  end
end
