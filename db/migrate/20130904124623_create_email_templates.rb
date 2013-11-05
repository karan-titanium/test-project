class CreateEmailTemplates < ActiveRecord::Migration
  def change
    create_table :email_templates do |t|
      t.string :name
      t.string :subject
      t.text :content_html
      t.text :content_plain

      t.timestamps
    end
  end
end
