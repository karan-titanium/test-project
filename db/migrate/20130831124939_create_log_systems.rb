class CreateLogSystems < ActiveRecord::Migration
  def change
    create_table :log_systems do |t|
      t.string  :event_type
      t.integer :user_id
      t.string  :ip
      t.text    :message
      t.text    :controller
      t.text    :action
      t.timestamps
    end
  end
end
