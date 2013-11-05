class CreateCompanyLogos < ActiveRecord::Migration
  def change
    create_table :company_logos do |t|
      t.integer :company_id
      t.integer :cdn_file_id
      t.timestamps
    end
  end
end
