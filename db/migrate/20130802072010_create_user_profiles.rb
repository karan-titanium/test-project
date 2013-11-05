class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.integer :user_id
      t.integer :photo
      t.string :passport
      t.string :eligableuk
      t.text :eligabledetails
      t.string :gender
      t.string :number_mob
      t.string :number_alt
      t.string :contact_method
      t.string :contact_time
      t.string :address_line1
      t.string :address_line2
      t.string :address_town
      t.string :address_country
      t.string :address_postcode
      t.integer :salary_current
      t.integer :salary_target
      t.string  :uk_driving_licence
      t.string  :employed 
      t.datetime  :date_of_birth
      t.datetime  :reminderemail1
      t.datetime  :reminderemail2
      t.datetime  :reminderemail3
      t.timestamps
    end
  end
end
