class CreateUserCompanies < ActiveRecord::Migration
  def change
    create_table :user_companies do |t|
      t.integer :user_id
      t.integer :company_id
      t.boolean :current
      t.boolean :clientcontact
      t.datetime :from
      t.datetime :untill
      t.string :position

      t.timestamps
    end
  end
end
