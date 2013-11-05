class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :status
      t.string :phone
      t.string :website
      t.string :address_line1
      t.string :address_line2
      t.string :address_town
      t.string :address_country
      t.string :address_postcode
      t.integer :contact
      t.boolean :whitelabel
      t.string :subdomain
      t.string :displayname
      t.text :profile
      t.integer :logo

      t.timestamps
    end
  end
end
